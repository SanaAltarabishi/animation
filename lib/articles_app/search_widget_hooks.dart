import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:reverse_string/articles_app/another_counter_hook.dart';
import 'package:reverse_string/articles_app/article_change_notifier.dart';
import 'package:reverse_string/articles_app/counter_hook.dart';
import 'package:reverse_string/articles_app/fab_hooks.dart';
import 'package:reverse_string/articles_app/singel_article_page.dart';
import 'package:reverse_string/articles_app/todo_hook.dart';

class SearchWidgetExample extends HookWidget {
  const SearchWidgetExample({super.key});

  @override
  Widget build(BuildContext context) {
    // Get access to the NewsChangeNotifier instance
    final notifier = context.read<NewsChangeNotifier>();
    final controller = useTextEditingController();
    useListenable(controller);
    final focusNode = useFocusNode();
    final searchEnable = useState(false);

    useEffect(() {
      Future.microtask(
        () => notifier.getArticles(),
      );
      return null;
    }, const []);

    useEffect(() {
      void onChange() {
        if (searchEnable.value) {
          focusNode.requestFocus();
        } else {
          focusNode.unfocus();
        }
      }

      searchEnable.addListener(onChange);
      return () => searchEnable.removeListener(onChange);
    }, const []);

    final searchResult = controller.text.isEmpty
        ? context.watch<NewsChangeNotifier>().articles
        : notifier.articles
            .where(
              (article) => article.title.toLowerCase().contains(
                    controller.text.toLowerCase(),
                  ),
            )
            .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Search Hook',
          style: TextStyle(
            color: Colors.blueGrey,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TodoPage(),
              ),
            );
          },
          icon: const Icon(
            Icons.check_box,
            color: Colors.blueGrey,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (searchEnable.value) {
                controller.clear();
              }
              searchEnable.value = !searchEnable.value;
            },
            icon: const Icon(
              Icons.search,
            ),
          ),
           IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CounterPage(),
                  ),
                );
              },
              icon: const Icon(
                Icons.one_k_outlined,
                color: Colors.blueGrey,
              ),
            ),
             IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Example2(),
                  ),
                );
              },
              icon: const Icon(
                Icons.two_k_outlined,
                color: Colors.blueGrey,
              ),
            ),
             IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  FabHooksAnimation(),
                  ),
                );
              },
              icon: const Icon(
                Icons.three_g_mobiledata,
                color: Colors.blueGrey,
              ),
            ),
        ],
      ),
      body: notifier.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                // Show search field when search is enabled
                Visibility(
                  visible: searchEnable.value,
                  child: TextField(
                    controller: controller,
                    focusNode: focusNode,
                    decoration: const InputDecoration(
                      hintText: 'Search articles...',
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: searchResult.length,
                    itemBuilder: (context, index) {
                      final article = searchResult[index];
                      return ListTile(
                        title: Text(article.title),
                        subtitle: Text(
                          article.content,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SingleArticlePage(
                                article: article,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
