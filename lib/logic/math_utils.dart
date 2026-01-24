int reduceToSingleDigit(int n) {
  if (n <= 0) return 0;
  return (n - 1) % 9 + 1;
}
