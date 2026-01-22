import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:signals/signals_flutter.dart';
import 'package:base9/theme/spacing.dart';
import 'package:base9/signals.dart';
import 'package:base9/widgets/date_analysis.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final breakpoints = context.theme.breakpoints;
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= breakpoints.md;
    final dateOfBirth = dateOfBirthSignal.watch(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Spacing.lg),
        child: SizedBox(
          width: isDesktop ? width / 3 : width,
          child: Column(
            spacing: Spacing.lg,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
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
                ],
              ),
              const SizedBox(height: Spacing.lg),
              FDateField(
                label: const Text('Дата Рождения'),
                description: const Text('Выберите дату рождения'),
                control: FDateFieldControl.lifted(
                  date: dateOfBirth,
                  onChange: (value) => dateOfBirthSignal.value = value,
                ),
                autofocus: true,
                clearable: true,
              ),
              const FDivider(),
              const DateAnalysis(),
            ],
          ),
        ),
      ),
    );
  }
}
