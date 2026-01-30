import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:upgrader/upgrader.dart';
import 'package:base9/theme/spacing.dart';
import 'package:base9/overlays/toast.dart';
import 'package:url_launcher/url_launcher.dart';

extension UpgraderDialog on Upgrader {
  void showUpgradeDialog(
    BuildContext context, {
    String? installed,
    String? available,
  }) {
    const unknown = 'неизвестна';
    final installedStr = installed ?? unknown;
    final availableStr = available ?? unknown;

    showDialog(
      context: context,
      builder: (context) => FDialog(
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
              final url = currentAppStoreListingURL;
              final launched =
                  url != null &&
                  await canLaunchUrl(Uri.parse(url)) &&
                  await launchUrl(
                    Uri.parse(url),
                    mode: LaunchMode.externalApplication,
                  );
              if (context.mounted) {
                Navigator.of(context).pop();
                if (!launched) {
                  context.showAppToast(
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
            style: FButtonStyle.outline(),
            onPress: () {
              Navigator.of(context).pop();
            },
            child: const Text('Позже'),
          ),
        ],
      ),
    );
  }
}
