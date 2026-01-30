import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:base9/theme/spacing.dart';
import 'package:base9/overlays/toast.dart';
import 'package:url_launcher/url_launcher.dart';

const _releasesPage = 'https://github.com/Reenuay/base9/releases';

extension UpdateDialogContext on BuildContext {
  void showUpdateDialog({
    required String installed,
    required String available,
  }) {
    const unknown = 'неизвестна';
    final installedStr = installed.isEmpty ? unknown : installed;
    final availableStr = available.isEmpty ? unknown : available;
    final url = available.isEmpty
        ? _releasesPage
        : '$_releasesPage/tag/v$availableStr';

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
              final launched = await launchUrl(
                Uri.parse(url),
                mode: LaunchMode.externalApplication,
              );
              if (dialogContext.mounted) {
                Navigator.of(dialogContext).pop();
                if (!launched) {
                  dialogContext.showAppToast(
                    title: const Text(
                      'Не удалось открыть ссылку на обновление 😭',
                    ),
                  );
                }
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
