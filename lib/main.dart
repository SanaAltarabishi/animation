import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ProblemQuestionsPage(),
    );
  }
}

class ProblemQuestionsPage extends StatefulWidget {
  const ProblemQuestionsPage({super.key});

  @override
  _ProblemQuestionsPageState createState() => _ProblemQuestionsPageState();
}

class _ProblemQuestionsPageState extends State<ProblemQuestionsPage> {
  final List<Map<String, dynamic>> items = [
    {"type": "question", "text": "سؤال عادي 1"},
    {"type": "problem", "text": "مشكلة 1", "count": 6},
    {"type": "question", "text": "سؤال ضمن مشكلة 1"},
    {"type": "question", "text": "سؤال ضمن مشكلة 1"},
    {"type": "question", "text": "سؤال ضمن مشكلة 1"},
    {"type": "question", "text": "سؤال ضمن مشكلة 1"},
    {"type": "question", "text": "سؤال ضمن مشكلة 1"},
    {"type": "question", "text": "سؤال ضمن مشكلة 1"},
    {"type": "problem", "text": "مشكلة 2", "count": 3},
    {"type": "question", "text": "سؤال ضمن مشكلة 2"},
    {"type": "question", "text": "سؤال ضمن مشكلة 2"},
    {"type": "question", "text": "سؤال ضمن مشكلة 2"},
    {"type": "question", "text": "سؤال عادي بعد المشاكل"},
  ];

  /// حالة expand/collapse لكل مشكلة
  final Map<int, bool> expandedProblems = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Problems & Questions")),
      body: CustomScrollView(slivers: _buildSlivers()),
    );
  }

  List<Widget> _buildSlivers() {
    final List<Widget> slivers = [];
    int i = 0;
    int questionNumber = 0; // عداد الأسئلة فقط

    while (i < items.length) {
      final item = items[i];

      if (item["type"] == "problem") {
        int count = item["count"];
        final questions = items.sublist(i + 1, i + 1 + count);
        final problemIndex = i;
        final isExpanded = expandedProblems[problemIndex] ?? true;

        if (isExpanded) {
          // Sticky header مع الأسئلة التابعة
          slivers.add(
            SliverStickyHeader(
              header: _buildHeader(item["text"], problemIndex, isExpanded),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  questionNumber++;
                  return ListTile(
                    title: Text(
                      "${questionNumber}. ${questions[index]["text"]}",
                    ),
                  );
                }, childCount: questions.length),
              ),
            ),
          );
        } else {
          // مشكلة مسكرة → مجرد عنصر عادي غير sticky
          slivers.add(
            SliverToBoxAdapter(
              child: _buildHeader(item["text"], problemIndex, isExpanded),
            ),
          );
        }

        i += 1 + count; // تخطي المشكلة وأسئلتها
      } else {
        // سؤال عادي
        questionNumber++;
        slivers.add(
          SliverList(
            delegate: SliverChildListDelegate([
              ListTile(title: Text("${questionNumber}. ${item["text"]}")),
            ]),
          ),
        );
        i++;
      }
    }

    return slivers;
  }

  Widget _buildHeader(String text, int problemIndex, bool isExpanded) {
    return GestureDetector(
      onTap: () {
        setState(() {
          expandedProblems[problemIndex] = !isExpanded;
        });
      },
      child: Container(
        color: Colors.red[300],
        padding: EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: TextStyle(color: Colors.white, fontSize: 16)),
            Icon(
              isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
