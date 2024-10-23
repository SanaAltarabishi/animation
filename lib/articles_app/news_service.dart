import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:reverse_string/articles_app/article.dart';
// simulating communication :
class NewsService {
  final _articles = List.generate(
    10,
    (_) => Article(
      title: lorem(paragraphs: 1, words: 3),
      content: lorem(paragraphs: 10, words: 500),
    ),
  );

  Future<List<Article>> getArticles() async {
    await Future.delayed(const Duration(seconds: 1));
    return _articles;
  }
}
