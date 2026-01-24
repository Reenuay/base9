import 'package:signals/signals.dart';
import 'package:base9/logic/math_utils.dart';

final dateOfBirthSignal = signal<DateTime?>(null);

final dayNumberSignal = computed<int?>(() {
  final date = dateOfBirthSignal.value;
  return date != null ? reduceToSingleDigit(date.day) : null;
});

final monthNumberSignal = computed<int?>(() {
  final date = dateOfBirthSignal.value;
  return date != null ? reduceToSingleDigit(date.month) : null;
});

final yearNumberSignal = computed<int?>(() {
  final date = dateOfBirthSignal.value;
  return date != null ? reduceToSingleDigit(date.year) : null;
});

final lifePathNumberSignal = computed<int?>(() {
  final d = dayNumberSignal.value;
  final m = monthNumberSignal.value;
  final y = yearNumberSignal.value;

  if (d == null || m == null || y == null) return null;

  return reduceToSingleDigit(d + m + y);
});

final naturalExpressionNumberSignal = computed<int?>(
  () => dayNumberSignal.value,
);

final endCycle1Signal = computed<int?>(() {
  final lp = lifePathNumberSignal.value;
  return lp != null ? 36 - lp : null;
});

final endCycle2Signal = computed<int?>(() {
  final e1 = endCycle1Signal.value;
  return e1 != null ? e1 + 9 : null;
});

final endCycle3Signal = computed<int?>(() {
  final e2 = endCycle2Signal.value;
  return e2 != null ? e2 + 9 : null;
});

final task1Signal = computed<int?>(() {
  final d = dayNumberSignal.value;
  final m = monthNumberSignal.value;
  return (d != null && m != null) ? reduceToSingleDigit(d + m) : null;
});

final task2Signal = computed<int?>(() {
  final d = dayNumberSignal.value;
  final y = yearNumberSignal.value;
  return (d != null && y != null) ? reduceToSingleDigit(d + y) : null;
});

final task3Signal = computed<int?>(() {
  final c1 = task1Signal.value;
  final c2 = task2Signal.value;
  return (c1 != null && c2 != null) ? reduceToSingleDigit(c1 + c2) : null;
});

final task4Signal = computed<int?>(() {
  final m = monthNumberSignal.value;
  final y = yearNumberSignal.value;
  return (m != null && y != null) ? reduceToSingleDigit(m + y) : null;
});

final problem1Signal = computed<int?>(() {
  final d = dayNumberSignal.value;
  final m = monthNumberSignal.value;
  return (d != null && m != null) ? (d - m).abs() : null;
});

final problem2Signal = computed<int?>(() {
  final d = dayNumberSignal.value;
  final y = yearNumberSignal.value;
  return (d != null && y != null) ? (d - y).abs() : null;
});

final problem3Signal = computed<int?>(() {
  final p1 = problem1Signal.value;
  final p2 = problem2Signal.value;
  return (p1 != null && p2 != null) ? (p1 - p2).abs() : null;
});

final problem4Signal = computed<int?>(() {
  final m = monthNumberSignal.value;
  final y = yearNumberSignal.value;
  return (m != null && y != null) ? (m - y).abs() : null;
});
