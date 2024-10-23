class Calculator {
  int add(int num1, int num2) {
    return num1 + num2;
  }

  int divideBy(int num1, int num2) {
    if (num2 == 0) throw Exception();
    return num1 ~/ num2;
  }
}
