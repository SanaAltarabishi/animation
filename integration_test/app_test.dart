import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:reverse_string/articles_app/article.dart';
import 'package:reverse_string/articles_app/article_change_notifier.dart';
import 'package:reverse_string/articles_app/articles_page.dart';
import 'package:reverse_string/articles_app/news_service.dart';
import 'package:reverse_string/articles_app/singel_article_page.dart';

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
    'Tapping on the first article opens the singleArtcile page where the full article content is displayed ',
    (WidgetTester tester) async {
      arrangeNewsServiceReturnsArticles();

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.pump();

      await tester.tap(
        find.text('Test 1 content'),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ArticlesPage), findsNothing);
      expect(find.byType(SingleArticlePage), findsOneWidget);

      expect(find.text('Test 1'), findsOneWidget);
      expect(find.text('Test 1 content'), findsOneWidget);
    },
  );
}
