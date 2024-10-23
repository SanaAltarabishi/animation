import 'package:flutter_test/flutter_test.dart';
import 'package:reverse_string/calculator/calculator.dart';

void main() {
  test(
    'Add method should return 5 if the inputs are  3 and 2',
    () {
      //?:  AAA:arrange | act | assert :
      //arrange: needed things
      final calculator = Calculator();
      const num1 = 3;
      const num2 = 2;
      const expectedResult = 5;
      //act: the thing i need to test :(function)and make a result form it
      final result = calculator.add(num1, num2);
      //assert:
      expect(result, expectedResult);
    },
  );

  test(
    'DividedBy method should return 5 if the inputs are 10 , 2',
    () {
//arrange :
      final calculator = Calculator();
      const num1 = 10;
      const num2 = 2;
      const expectedResult = 5;
//act :
      final result = calculator.divideBy(num1, num2);
//assert:
      expect(result, expectedResult);
    },
  );

  test(
    'DivideBy method should throw an exeption if num2 is 0',
    () {
//arrange :
      final calculator = Calculator();
      const num1 = 10;
      const num2 = 0;
      final expectedResult = throwsA(isA<Exception>());
//act :
      final result = () => calculator.divideBy(num1, num2);
      //becuse this don't return a value it throw an exeption that why we make it as a function
//assert:
      expect(result, expectedResult);
    },
  );
}
