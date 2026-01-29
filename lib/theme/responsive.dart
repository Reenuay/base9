import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

extension ResponsiveContext on BuildContext {
  bool get isWideScreen =>
      MediaQuery.sizeOf(this).width >= theme.breakpoints.md;
}
