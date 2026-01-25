import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:upgrader/upgrader.dart';
import 'package:version/version.dart';
import 'package:base9/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = FThemes.zinc;
    return MaterialApp(
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
        upgrader: Upgrader(
          storeController: UpgraderStoreController(
            onAndroid: () => UpgraderAppcastStore(
              appcastURL:
                  'https://raw.githubusercontent.com/Reenuay/base9/main/appcast.xml',
              osVersion: Version(1, 0, 0),
            ),
          ),
          durationUntilAlertAgain: Duration.zero,
          debugLogging: true,
        ),
        child: const FScaffold(childPad: false, child: HomePage()),
      ),
    );
  }
}
