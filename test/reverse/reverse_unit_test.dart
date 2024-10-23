import 'package:flutter_test/flutter_test.dart';
import 'package:reverse_string/reverse/reverse_page.dart';

//unit testing to test function :
void main() {
  test(
    'String should be reversed',
    () {
      String initalWord = "Hello";
      String reversedWord = reverseFunction(initalWord);
      expect(reversedWord, "olleH");
    },
  );
}
