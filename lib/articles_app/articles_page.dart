import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reverse_string/articles_app/article_change_notifier.dart';
import 'package:reverse_string/articles_app/singel_article_page.dart';

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({super.key});

  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<NewsChangeNotifier>().getArticles(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('News'),
        backgroundColor: Colors.white,
      ),
      body: Consumer<NewsChangeNotifier>(
        builder: (context, notifier, child) {
          if (notifier.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: notifier.articles.length,
            itemBuilder: (_, index) {
              final article = notifier.articles[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                height: 100,
                child: Card(
                  color: Colors.blueGrey.withOpacity(0.85),
                  elevation: 2,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SingleArticlePage(
                          article: article,
                        ),
                      ));
                    },
                    child: ListTile(
                      title: Text(article.title),
                      subtitle: Text(article.content,
                          style:
                              const TextStyle(overflow: TextOverflow.ellipsis)),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
