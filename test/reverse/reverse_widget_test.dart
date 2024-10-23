// بشوف اذا الودجيت موجودة بال widget tree
//test field if it exist >>enter text >>
//text exist >> button >> click
//the text of the result exist
//>>so widget work !!
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reverse_string/reverse/reverse_page.dart';

void main() {
  testWidgets(
    'ReverseString widget test',
    (widgetTester) async {
      await widgetTester.pumpWidget(
        const MaterialApp(
          home: ReversePage(),
        ),
      );

      var reverseStringtextField = find.byType(TextField);
      expect(reverseStringtextField, findsOneWidget);

      await widgetTester.enterText(reverseStringtextField, 'Hello');
      expect(find.text('Hello'), findsOneWidget);

      var reverseButton = find.text('Reverese');
      expect(reverseButton, findsOneWidget);

      await widgetTester.tap(reverseButton);

      await widgetTester.pump();

      expect(find.text('olleH'), findsOneWidget);
    },
  );
}
