import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forui/forui.dart';
import 'package:signals/signals_flutter.dart';
import 'package:base9/signals.dart';

class CopyButton extends StatelessWidget {
  const CopyButton({super.key});

  void _copy(BuildContext context) {
    final dob = dateOfBirthSignal.value;
    if (dob == null) return;

    final text =
        '''
BASE9 Анализ
Дата: ${dob.day}.${dob.month}.${dob.year}
Разбор: ${dayNumberSignal.value} - ${monthNumberSignal.value} - ${yearNumberSignal.value}

ЧЖП: ${lifePathNumberSignal.value}
ЧЕП: ${naturalExpressionNumberSignal.value}

Циклы:
I: 1 - ${endCycle1Signal.value}, Задача: ${task1Signal.value}, Проблема: ${problem1Signal.value}
II: ${endCycle1Signal.value} - ${endCycle2Signal.value}, Задача: ${task2Signal.value}, Проблема: ${problem2Signal.value}
III: ${endCycle2Signal.value} - ${endCycle3Signal.value}, Задача: ${task3Signal.value}, Проблема: ${problem3Signal.value}
IV: ${endCycle3Signal.value} - ∞, Задача: ${task4Signal.value}, Проблема: ${problem4Signal.value}
''';

    Clipboard.setData(ClipboardData(text: text));
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final dateOfBirth = dateOfBirthSignal.watch(context);
    if (dateOfBirth == null) return const SizedBox.shrink();

    return FTappable(
      onPress: () => _copy(context),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: theme.colors.primary,
          boxShadow: theme.style.shadow,
        ),
        child: Icon(FIcons.copy, color: theme.colors.primaryForeground),
      ),
    );
  }
}
