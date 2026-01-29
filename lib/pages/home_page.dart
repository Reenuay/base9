import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:signals/signals_flutter.dart';
import 'package:base9/theme/spacing.dart';
import 'package:base9/signals.dart';
import 'package:base9/widgets/date_analysis.dart';
import 'package:base9/widgets/numbers_analysis.dart';
import 'package:base9/widgets/cycles_table.dart';
import 'package:base9/widgets/copy_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final breakpoints = context.theme.breakpoints;
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= breakpoints.md;
    final dateOfBirth = dateOfBirthSignal.watch(context);

    return Stack(
      children: [
        Center(
          child: FractionallySizedBox(
            widthFactor: isDesktop ? 1 / 3 : 1,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(Spacing.lg),
                child: Column(
                  children: [
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
                    FDateField.calendar(
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
                    ),
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
              ),
            ),
          ),
        ),
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
