import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:reverse_string/articles_app/article_change_notifier.dart';
import 'package:reverse_string/articles_app/news_service.dart';
import 'package:reverse_string/articles_app/search_widget_hooks.dart';

class SplashScreen extends HookWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
        duration: const Duration(seconds: 1), initialValue: 1);

    Animation<Offset> offset = useMemoized(
      () => Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero)
          .animate(controller),
    );

    useEffect(
      () {
        controller.repeat(reverse: true);

        Future.delayed(
          const Duration(seconds: 4),
          () {
            Route route = MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (context) =>
                 NewsChangeNotifier(
                  NewsService(),
                ),
                child:const SearchWidgetExample()
               //  const ArticlesPage(),
              ),
            );
            // ignore: use_build_context_synchronously
            Navigator.of(context).pushReplacement(route);
          },
        );
        return null;
      },
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: FadeTransition(
            opacity: controller,
            child: SlideTransition(
              position: offset,
              child: Icon(
                Icons.newspaper,
                color: Colors.blueGrey.withOpacity(0.85),
                size: 80,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
