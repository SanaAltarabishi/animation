import 'package:flutter/material.dart';
import 'package:reverse_string/articles_app/article.dart';

class SingleArticlePage extends StatelessWidget {
  final Article article;
  const SingleArticlePage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: mq.padding.bottom,
            top: mq.padding.top,
            left: 8,
            right: 8,
          ),
          child: Column(
            children: [
              Text(
                article.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(article.content),
            ],
          ),
        ),
      ),
    );
  }
}
