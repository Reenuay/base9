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
