import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:signals/signals_flutter.dart';
import 'package:base9/theme/spacing.dart';
import 'package:base9/theme/responsive.dart';
import 'package:base9/signals.dart';
import 'package:base9/widgets/date_analysis.dart';
import 'package:base9/widgets/numbers_analysis.dart';
import 'package:base9/widgets/cycles_table.dart';
import 'package:base9/widgets/logo.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FractionallySizedBox(
        widthFactor: context.isWideScreen ? 1 / 2 : 1,
        child: const _Content(),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: Spacing.x4l),
        const Logo(),
        const Icon(FIcons.star),
        const SizedBox(height: Spacing.lg),
        Watch((context) {
          final dateOfBirth = dateOfBirthSignal.value;
          return FDateField.calendar(
            label: const Text('Дата Рождения'),
            description: const Text('Выберите дату рождения'),
            anchor: Alignment.topCenter,
            fieldAnchor: Alignment.bottomCenter,
            control: FDateFieldControl.lifted(
              date: dateOfBirth,
              onChange: (value) {
                if (value != null) dateOfBirthSignal.value = value;
              },
            ),
          );
        }),
        const SizedBox(height: Spacing.xl),
        const DateAnalysis(),
        const FDivider(),
        const Icon(FIcons.chevronDown),
        const SizedBox(height: Spacing.lg),
        const NumbersAnalysis(),
        const SizedBox(height: Spacing.xl),
        const CyclesTable(),
        const SizedBox(height: Spacing.x4l),
      ],
    );
  }
}
