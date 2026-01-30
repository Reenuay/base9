import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

const _channel = MethodChannel('base9/install_apk');
const _apkUrlPrefix = 'https://github.com/Reenuay/base9/releases/download';

Future<bool> downloadAndInstallApk(String version) async {
  if (!Platform.isAndroid) return false;
  final url = '$_apkUrlPrefix/v$version/app-release.apk';
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) return false;
    final bytes = response.bodyBytes;
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/app-release-$version.apk');
    await file.writeAsBytes(bytes);
    await _channel.invokeMethod<void>('installApk', {'path': file.path});
    return true;
  } catch (_) {
    return false;
  }
}
