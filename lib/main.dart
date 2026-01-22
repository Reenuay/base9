import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

void main() {
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = FThemes.zinc;
    return MaterialApp(
      theme: theme.light.toApproximateMaterialTheme(),
      darkTheme: theme.dark.toApproximateMaterialTheme(),
      themeMode: ThemeMode.system,
      builder: (context, child) => FAnimatedTheme(
        data: MediaQuery.platformBrightnessOf(context) == Brightness.dark
            ? theme.dark
            : theme.light,
        child: child!,
      ),
      home: FScaffold(
        child: Center(
          child: FButton(
            style: FButtonStyle.outline(),
            mainAxisSize: MainAxisSize.min,
            onPress: () {},
            suffix: Icon(FIcons.plus),
            child: Text('Add'),
          ),
        ),
      ),
    );
  }
}
