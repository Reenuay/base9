import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:signals/signals_flutter.dart';
import 'package:base9/theme/spacing.dart';
import 'package:base9/theme/responsive.dart';
import 'package:base9/signals.dart';
import 'package:base9/widgets/date_analysis.dart';
import 'package:base9/widgets/numbers_analysis.dart';
import 'package:base9/widgets/cycles_table.dart';
import 'package:base9/widgets/copy_button.dart';
import 'package:base9/widgets/app_version.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.isWideScreen) {
      return const FractionallySizedBox(widthFactor: 1 / 3, child: _Scaffold());
    }

    return const _Scaffold();
  }
}

class _Scaffold extends StatelessWidget {
  const _Scaffold();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const SingleChildScrollView(child: _Content()),
        Positioned(
          bottom: Spacing.lg,
          left: 0,
          right: 0,
          child: const Center(child: CopyButton()),
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Spacing.lg),
      child: Column(
        children: [
          const Align(alignment: Alignment.centerLeft, child: AppVersion()),
          const SizedBox(height: Spacing.x4l),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'BASE',
                style: context.theme.typography.xl7.copyWith(
                  fontWeight: FontWeight.w900,
                  height: 1,
                ),
              ),
              Text(
                '9',
                style: context.theme.typography.xl4.copyWith(
                  fontWeight: FontWeight.w900,
                  height: 1,
                ),
              ),
            ],
          ),
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
      ),
    );
  }
}
