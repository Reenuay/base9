import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:signals/signals_flutter.dart';
import 'package:base9/signals.dart';

class CyclesTable extends StatelessWidget {
  const CyclesTable({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final borderSide = BorderSide(color: theme.colors.border);

    final e1 = endCycle1Signal.watch(context);
    final e2 = endCycle2Signal.watch(context);
    final e3 = endCycle3Signal.watch(context);

    final t1 = task1Signal.watch(context);
    final t2 = task2Signal.watch(context);
    final t3 = task3Signal.watch(context);
    final t4 = task4Signal.watch(context);

    final p1 = problem1Signal.watch(context);
    final p2 = problem2Signal.watch(context);
    final p3 = problem3Signal.watch(context);
    final p4 = problem4Signal.watch(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: theme.colors.border),
        borderRadius: theme.style.borderRadius,
      ),
      child: ClipRRect(
        borderRadius: theme.style.borderRadius,
        child: Table(
          columnWidths: const {
            0: IntrinsicColumnWidth(),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(3),
            3: FlexColumnWidth(2),
            4: FlexColumnWidth(2),
          },
          border: TableBorder(
            horizontalInside: borderSide,
            verticalInside: borderSide,
          ),
          children: [
            _header(context),
            _row(context, 'I', 'Весна', '1 - $e1', t1, p1),
            _row(context, 'II', 'Лето', '$e1 - $e2', t2, p2),
            _row(context, 'III', 'Осень', '$e2 - $e3', t3, p3),
            _row(context, 'IV', 'Зима', '$e3 - ∞', t4, p4),
          ],
        ),
      ),
    );
  }

  TableRow _header(BuildContext context) {
    final style = context.theme.typography.xs.copyWith(
      color: context.theme.colors.mutedForeground,
      fontWeight: FontWeight.w600,
    );
    return TableRow(
      decoration: BoxDecoration(color: context.theme.colors.barrier),
      children: [
        _cell('№', style),
        _cell('Сезон', style),
        _cell('Период', style),
        _cell('Задача', style),
        _cell('Проблема', style),
      ],
    );
  }

  TableRow _row(
    BuildContext context,
    String num,
    String season,
    String period,
    int task,
    int problem,
  ) {
    final style = context.theme.typography.sm.copyWith(
      fontWeight: FontWeight.w500,
    );

    return TableRow(
      children: [
        _cell(num, style),
        _cell(season, style),
        _cell(period, style),
        _cell(
          task.toString(),
          style.copyWith(color: context.theme.colors.primary),
        ),
        _cell(
          problem != 0 ? problem.toString() : '-',
          style.copyWith(color: context.theme.colors.error),
        ),
      ],
    );
  }

  Widget _cell(String text, TextStyle style) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
    child: Center(
      child: Text(text, style: style, textAlign: TextAlign.center),
    ),
  );
}
