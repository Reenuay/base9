int reduceToSingleDigit(int n) {
  if (n <= 0) return 0;
  return (n - 1) % 9 + 1;
}

int calculateLifePath(int day, int month, int year) => reduceToSingleDigit(day + month + year);
