import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:signals/signals_flutter.dart';
import 'package:base9/signals.dart';

class NumbersAnalysis extends StatelessWidget {
  const NumbersAnalysis({super.key});

  @override
  Widget build(BuildContext context) {
    final lifePath = lifePathNumberSignal.watch(context);
    final naturalExpression = naturalExpressionNumberSignal.watch(context);

    return Row(
      children: [
        const Spacer(),
        Expanded(
          flex: 2,
          child: _NumberCard(label: 'ЧЖП', value: lifePath),
        ),
        const Spacer(),
        Expanded(
          flex: 2,
          child: _NumberCard(label: 'ЧЕП', value: naturalExpression),
        ),
        const Spacer(),
      ],
    );
  }
}

class _NumberCard extends StatelessWidget {
  final String label;
  final int? value;

  const _NumberCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return AspectRatio(
      aspectRatio: 1,
      child: FCard.raw(
        style: (style) => style.copyWith(
          decoration: style.decoration.copyWith(color: theme.colors.barrier),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                label,
                textAlign: TextAlign.center,
                style: theme.typography.xs.copyWith(
                  color: theme.colors.mutedForeground,
                  height: 1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                value?.toString() ?? '-',
                textAlign: TextAlign.center,
                style: theme.typography.xl4.copyWith(
                  fontWeight: FontWeight.w900,
                  height: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
