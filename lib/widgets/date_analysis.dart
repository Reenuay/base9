import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:signals/signals_flutter.dart';
import 'package:base9/signals.dart';

class DateAnalysis extends StatelessWidget {
  const DateAnalysis({super.key});

  Widget _part(int? value, TextStyle style) {
    if (value == null) {
      return Icon(FIcons.star, size: style.fontSize);
    }
    return Text('$value', style: style);
  }

  Widget _separator(TextStyle style) => Text(' - ', style: style);

  @override
  Widget build(BuildContext context) {
    final day = dayNumberSignal.watch(context);
    final month = monthNumberSignal.watch(context);
    final year = yearNumberSignal.watch(context);

    final style = context.theme.typography.xl2.copyWith(
      fontWeight: FontWeight.w600,
      height: 1,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _part(day, style),
        _separator(style),
        _part(month, style),
        _separator(style),
        _part(year, style),
      ],
    );
  }
}
