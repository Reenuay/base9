// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

const _svgPath = 'assets/icon/base9.svg';
const _androidRes = 'android/app/src/main/res';

const _androidSizes = [
  (48, 'mipmap-mdpi'),
  (72, 'mipmap-hdpi'),
  (96, 'mipmap-xhdpi'),
  (144, 'mipmap-xxhdpi'),
  (192, 'mipmap-xxxhdpi'),
];

const _windowsSizes = [16, 32, 48, 256];
const _windowsIcoPath = 'windows/runner/resources/app_icon.ico';
const _svgViewBox = 1024.0;

void main() {
  testWidgets('generate launcher icons from SVG', (tester) async {
    await tester.runAsync(() async {
      final svgFile = File(_svgPath);
      if (!await svgFile.exists()) {
        throw Exception('SVG not found: $_svgPath');
      }
      final svgString = await svgFile.readAsString();

      final pictureInfo = await vg.loadPicture(
        SvgStringLoader(svgString),
        null,
      );
      addTearDown(pictureInfo.picture.dispose);

      for (final (size, folder) in _androidSizes) {
        final image = await _renderSvgToImage(
          pictureInfo.picture,
          size.toDouble(),
        );
        final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
        final out = File('$_androidRes/$folder/ic_launcher.png');
        await out.parent.create(recursive: true);
        await out.writeAsBytes(byteData!.buffer.asUint8List());
        print('$_androidRes/$folder/ic_launcher.png ($size×$size)');
      }

      final windowsPngs = <List<int>>[];
      for (final size in _windowsSizes) {
        final image = await _renderSvgToImage(
          pictureInfo.picture,
          size.toDouble(),
        );
        final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
        windowsPngs.add(byteData!.buffer.asUint8List());
        print('Windows $size×$size');
      }
      await _writeIco(_windowsIcoPath, _windowsSizes, windowsPngs);
      print(_windowsIcoPath);
    });
  });
}

Future<ui.Image> _renderSvgToImage(ui.Picture picture, double size) async {
  final recorder = ui.PictureRecorder();
  final canvas = ui.Canvas(
    recorder,
    ui.Rect.fromLTWH(0, 0, _svgViewBox, _svgViewBox),
  );
  canvas.scale(size / _svgViewBox, size / _svgViewBox);
  canvas.drawPicture(picture);
  final composite = recorder.endRecording();
  final image = await composite.toImage(size.round(), size.round());
  composite.dispose();
  return image;
}

Future<void> _writeIco(
  String path,
  List<int> sizes,
  List<List<int>> pngBytes,
) async {
  final out = <int>[];
  out.addAll([0, 0, 1, 0]);
  out.addAll([sizes.length, 0]);
  int offset = 6 + 16 * sizes.length;
  for (var i = 0; i < sizes.length; i++) {
    final w = sizes[i];
    final h = w;
    final size = pngBytes[i].length;
    out.add(w == 256 ? 0 : w);
    out.add(h == 256 ? 0 : h);
    out.addAll([0, 0, 1, 0, 32, 0]);
    out.addAll(_u32le(size));
    out.addAll(_u32le(offset));
    offset += size;
  }
  for (final p in pngBytes) {
    out.addAll(p);
  }
  await File(path).writeAsBytes(out);
}

List<int> _u32le(int v) {
  return [v & 0xff, (v >> 8) & 0xff, (v >> 16) & 0xff, (v >> 24) & 0xff];
}
