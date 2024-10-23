import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reverse_string/articles_app/article.dart';
import 'package:reverse_string/articles_app/article_change_notifier.dart';
import 'package:reverse_string/articles_app/news_service.dart';
// unit test : test the logic
//widget : user interface , tapping ,only single widget,
//integration : multi components .. performance of the app ...
//! : way 1 :<<bad way >>
class BadMockNewsService implements NewsService {
  bool getArticalesCalled = false;
  @override
  Future<List<Article>> getArticles() async {
    getArticalesCalled = true;
    return [
      Article(title: 'Test 1', content: 'Test 1 content'),
      Article(title: 'Test 2', content: 'Test 2 content'),
      Article(title: 'Test 3', content: 'Test 3 content'),
      Article(title: 'Test 4', content: 'Test 4 content'),
    ];
  }
}

//! way 2: mocktail package:
class MockNewsService extends Mock implements NewsService {}

void main() {
  late NewsChangeNotifier sut; // system under test
  late MockNewsService mockNewsService;
  setUp(
    () {
      mockNewsService = MockNewsService();
      sut = NewsChangeNotifier(mockNewsService);
    },
  );

  test(
    'initail values are correct',
    () {
      expect(sut.articles, []);
      expect(sut.isLoading, false);
    },
  );

  group(
    'get Articles',
    () {
      final articlesFromService = [
        Article(title: 'Test 1', content: 'Test 1 content'),
        Article(title: 'Test 2', content: 'Test 2 content'),
        Article(title: 'Test 3', content: 'Test 3 content'),
        Article(title: 'Test 4', content: 'Test 4 content'),
      ];
      void arrangeNewsServiceReturnsArticles() {
        when(() => mockNewsService.getArticles()).thenAnswer((_) async =>articlesFromService);
      }

      test(
        'get articles using NewsService',
        () async {
          //   when(() => mockNewsService.getArticles()).thenAnswer((_) async => []);
          arrangeNewsServiceReturnsArticles();
          await sut.getArticles();
          verify(() => mockNewsService.getArticles()).called(1);
        },
      );
      test(
        """indicates loading of data,
         sets articles to the ones from the service,
         indicates that data is not being loaded anymore . """,
        () async {
          arrangeNewsServiceReturnsArticles();
          //   await sut.getArticles(); // we can do it like this because itLoading will became false again
          final futute = sut.getArticles();
          expect(sut.isLoading, true);
          await futute;
          expect(sut.articles,articlesFromService);
          expect(sut.isLoading, false);
        },
      );
    },
  );
}
