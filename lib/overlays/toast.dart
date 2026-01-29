import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

extension AppToastContext on BuildContext {
  void showAppToast({required Widget title}) {
    showFToast(
      context: this,
      title: title,
      alignment: FToastAlignment.topCenter,
      duration: const Duration(seconds: 3),
    );
  }
}
