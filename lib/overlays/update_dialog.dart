import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forui/forui.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:base9/theme/spacing.dart';
import 'package:base9/overlays/toast.dart';

const _installChannel = MethodChannel('base9/install_apk');
const _apkUrlPrefix = 'https://github.com/Reenuay/base9/releases/download';

Future<bool> _downloadAndInstallApk(String version) async {
  if (!Platform.isAndroid) return false;
  final url = '$_apkUrlPrefix/v$version/app-release.apk';
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) return false;
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/app-release-$version.apk');
    await file.writeAsBytes(response.bodyBytes);
    await _installChannel.invokeMethod<void>('installApk', {'path': file.path});
    return true;
  } catch (_) {
    return false;
  }
}

extension UpdateDialogContext on BuildContext {
  void showUpdateDialog({
    required String installed,
    required String available,
  }) {
    const unknown = 'неизвестна';
    final installedStr = installed.isEmpty ? unknown : installed;
    final availableStr = available.isEmpty ? unknown : available;

    showDialog(
      context: this,
      builder: (dialogContext) => FDialog(
        style: (themeStyle) => themeStyle.copyWith(
          decoration: themeStyle.decoration.copyWith(color: theme.colors.muted),
        ),
        direction: Axis.vertical,
        title: const Text('Обновление'),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: Spacing.lg),
          child: Text(
            'Доступная версия — $availableStr (у вас $installedStr). Хотите обновить?',
          ),
        ),
        actions: [
          FButton(
            onPress: () async {
              Navigator.of(dialogContext).pop();
              final ok = await _downloadAndInstallApk(availableStr);
              if (dialogContext.mounted && !ok) {
                dialogContext.showAppToast(
                  title: const Text(
                    'Не удалось скачать или установить обновление',
                  ),
                );
              }
            },
            child: const Text('Обновить'),
          ),
          const SizedBox(width: Spacing.md),
          FButton(
            style: FButtonStyle.outline(
              (themeOutline) => themeOutline.copyWith(
                decoration: themeOutline.decoration.map(
                  (d) => d.copyWith(
                    border: Border.all(color: theme.colors.foreground),
                  ),
                ),
              ),
            ),
            onPress: () => Navigator.of(dialogContext).pop(),
            child: const Text('Позже'),
          ),
        ],
      ),
    );
  }
}
