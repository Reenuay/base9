import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:signals/signals_flutter.dart';
import 'package:base9/signals.dart';

class DateAnalysis extends StatelessWidget {
  const DateAnalysis({super.key});

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
      children: [
        Text('$day', style: style),
        Text(' - ', style: style),
        Text('$month', style: style),
        Text(' - ', style: style),
        Text('$year', style: style),
      ],
    );
  }
}
