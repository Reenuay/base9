import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:base9/pages/home_page.dart';
import 'package:base9/widgets/update_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  static final navigatorKey = GlobalKey<NavigatorState>();

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
        child: FToaster(
          child: Padding(
            padding: MediaQuery.paddingOf(context),
            child: UpdateCheck(
              navigatorKey: navigatorKey,
              child: FScaffold(childPad: false, child: child!),
            ),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}
