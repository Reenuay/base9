import 'package:signals/signals.dart';
import 'package:base9/logic/math_utils.dart';

final dateOfBirthSignal = signal<DateTime>(DateTime.now());

final dayNumberSignal = computed<int>(() {
  return reduceToSingleDigit(dateOfBirthSignal.value.day);
});

final monthNumberSignal = computed<int>(() {
  return reduceToSingleDigit(dateOfBirthSignal.value.month);
});

final yearNumberSignal = computed<int>(() {
  return reduceToSingleDigit(dateOfBirthSignal.value.year);
});

final lifePathNumberSignal = computed<int>(() {
  final d = dayNumberSignal.value;
  final m = monthNumberSignal.value;
  final y = yearNumberSignal.value;
  return reduceToSingleDigit(d + m + y);
});

final naturalExpressionNumberSignal = computed<int>(
  () => dayNumberSignal.value,
);

final endCycle1Signal = computed<int>(() {
  return 36 - lifePathNumberSignal.value;
});

final endCycle2Signal = computed<int>(() => endCycle1Signal.value + 9);
final endCycle3Signal = computed<int>(() => endCycle2Signal.value + 9);

final task1Signal = computed<int>(() {
  return reduceToSingleDigit(dayNumberSignal.value + monthNumberSignal.value);
});

final task2Signal = computed<int>(() {
  return reduceToSingleDigit(dayNumberSignal.value + yearNumberSignal.value);
});

final task3Signal = computed<int>(() {
  return reduceToSingleDigit(task1Signal.value + task2Signal.value);
});

final task4Signal = computed<int>(() {
  return reduceToSingleDigit(monthNumberSignal.value + yearNumberSignal.value);
});

final problem1Signal = computed<int>(() {
  return (dayNumberSignal.value - monthNumberSignal.value).abs();
});

final problem2Signal = computed<int>(() {
  return (dayNumberSignal.value - yearNumberSignal.value).abs();
});

final problem3Signal = computed<int>(() {
  return (problem1Signal.value - problem2Signal.value).abs();
});

final problem4Signal = computed<int>(() {
  return (monthNumberSignal.value - yearNumberSignal.value).abs();
});
