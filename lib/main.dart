import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:base9/pages/home_page.dart';

void main() {
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
        child: child!,
      ),
      home: const FScaffold(child: HomePage()),
    );
  }
}
