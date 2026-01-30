import 'package:flutter/material.dart';

class NavigatorKeyScope extends InheritedWidget {
  const NavigatorKeyScope({
    super.key,
    required this.navigatorKey,
    required super.child,
  });

  final GlobalKey<NavigatorState> navigatorKey;

  static GlobalKey<NavigatorState>? of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<NavigatorKeyScope>()
      ?.navigatorKey;

  @override
  bool updateShouldNotify(NavigatorKeyScope oldWidget) =>
      navigatorKey != oldWidget.navigatorKey;
}
