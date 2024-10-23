import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:reverse_string/articles_app/article.dart';
import 'package:reverse_string/articles_app/article_change_notifier.dart';
import 'package:reverse_string/articles_app/articles_page.dart';
import 'package:reverse_string/articles_app/news_service.dart';

class MockNewsService extends Mock implements NewsService {}

void main() {
  late MockNewsService mockNewsService;
  setUp(() {
    mockNewsService = MockNewsService();
  });

  final articlesFromService = [
    Article(title: 'Test 1', content: 'Test 1 content'),
    Article(title: 'Test 2', content: 'Test 2 content'),
    Article(title: 'Test 3', content: 'Test 3 content'),
    Article(title: 'Test 4', content: 'Test 4 content'),
  ];

  void arrangeNewsServiceReturnsArticles() {
    when(() => mockNewsService.getArticles())
        .thenAnswer((_) async => articlesFromService);
  }

  void arrangeNewsServiceReturnsArticlesAfterTwoSecondsWait() {
    when(() => mockNewsService.getArticles()).thenAnswer((_) async {
      await Future.delayed(Duration(seconds: 2));
      return articlesFromService;
    });
  }

  Widget createWidgetUnderTest() {
    return MaterialApp(
      title: 'News App',
      home: ChangeNotifierProvider(
        create: (context) => NewsChangeNotifier(mockNewsService),
        child: const ArticlesPage(),
      ),
    );
  }

  testWidgets(
    'title is displayed',
    (WidgetTester tester) async {
      arrangeNewsServiceReturnsArticles();
      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.text('News'), findsOneWidget);
    },
  );

//if the article loading or circle progress indicator :

  testWidgets(
    'loading indicator is displayed while waiting for articles ',
    (WidgetTester tester) async {
      arrangeNewsServiceReturnsArticlesAfterTwoSecondsWait();

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.pump(
        const Duration(milliseconds: 500),
      );
      expect(
        find.byType(CircularProgressIndicator),
        findsOneWidget,
      );
      await tester.pumpAndSettle();
    },
  );

  testWidgets(
    'articles are displayed ',
    (WidgetTester tester) async {
      arrangeNewsServiceReturnsArticles();
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();
      for (final article in articlesFromService) {
        expect(find.text(article.title), findsOneWidget);
        expect(find.text(article.content), findsOneWidget);
      }
    },
  );
}
