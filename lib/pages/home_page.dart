import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:base9/theme/spacing.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final breakpoints = context.theme.breakpoints;
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= breakpoints.md;

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
              SizedBox(height: Spacing.lg),
              FDateField(
                label: const Text('Дата Рождения'),
                description: const Text('Выберите дату рождения'),
                autofocus: true,
                clearable: true,
              ),
              const FDivider(),
            ],
          ),
        ),
      ),
    );
  }
}
