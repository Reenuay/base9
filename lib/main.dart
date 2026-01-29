import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:upgrader/upgrader.dart';
import 'package:version/version.dart';
import 'package:base9/pages/home_page.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  static final navigatorKey = GlobalKey<NavigatorState>();

  static void _willDisplay({
    required bool display,
    String? installedVersion,
    UpgraderVersionInfo? versionInfo,
  }) {
    if (display) {
      _showUpgradeDialog(
        installedVersion,
        versionInfo?.appStoreVersion?.toString(),
      );
    }
  }

  static final Upgrader _upgrader = Upgrader(
    storeController: UpgraderStoreController(
      onAndroid: () => UpgraderAppcastStore(
        appcastURL:
            'https://raw.githubusercontent.com/Reenuay/base9/main/appcast.xml',
        osVersion: Version(1, 0, 0),
      ),
    ),
    durationUntilAlertAgain: Duration.zero,
    debugLogging: true,
    willDisplayUpgrade: _willDisplay,
  );

  static void _showUpgradeDialog(String? installed, String? available) {
    final context = navigatorKey.currentContext;
    if (context == null) return;

    showDialog(
      context: context,
      builder: (context) => FDialog(
        direction: Axis.vertical,
        title: const Text('Обновление'),
        body: Text(
          'Доступна версия $available (у вас $installed). Хотите обновить?',
        ),
        actions: [
          FButton(
            onPress: () async {
              final url = _upgrader.currentAppStoreListingURL;
              if (url != null && await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(
                  Uri.parse(url),
                  mode: LaunchMode.externalApplication,
                );
              }
              if (context.mounted) Navigator.of(context).pop();
            },
            child: const Text('Обновить'),
          ),
          FButton(
            style: context.theme.buttonStyles.outline,
            onPress: () {
              Navigator.of(context).pop();
            },
            child: const Text('Позже'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = FThemes.zinc;

    return MaterialApp(
      navigatorKey: navigatorKey,
      localizationsDelegates: FLocalizations.localizationsDelegates,
      supportedLocales: FLocalizations.supportedLocales,
      theme: theme.light.toApproximateMaterialTheme(),
      darkTheme: theme.dark.toApproximateMaterialTheme(),
      themeMode: ThemeMode.system,
      builder: (context, child) => FAnimatedTheme(
        data: MediaQuery.platformBrightnessOf(context) == Brightness.dark
            ? theme.dark
            : theme.light,
        child: FToaster(child: child!),
      ),
      home: UpgradeAlert(
        upgrader: _upgrader,
        showIgnore: false,
        showLater: false,
        showReleaseNotes: false,
        child: const FScaffold(childPad: false, child: HomePage()),
      ),
    );
  }
}
