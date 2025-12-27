import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const DragDropPage(),
    );
  }
}

class TaskItem {
  final String id;
  String title;
  Color color;
  TaskItem({required this.id, required this.title, required this.color});
}

//__________________________________________
class DragDropPage extends StatefulWidget {
  const DragDropPage({super.key});

  @override
  State<DragDropPage> createState() => _DragDropPageState();
}

class _DragDropPageState extends State<DragDropPage> {
  Map<String, List<TaskItem>> columns = {
    'قائمة المهام': [
      TaskItem(id: '1', title: 'تصميم الواجهة', color: Colors.blue.shade100),
      TaskItem(id: '2', title: 'كتابة الكود', color: Colors.green.shade100),
      TaskItem(id: '3', title: 'اختبار التطبيق', color: Colors.orange.shade100),
    ],
    'قيد التنفيذ': [
      TaskItem(id: '4', title: 'مراجعة الكود', color: Colors.pink.shade100),
    ],
    'مكتمل': [],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('📋 Unified Kanban Board')),
      // Vertical Scroll for the whole page
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          // Horizontal Scroll for the columns
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: columns.keys.map((columnName) {
                return _buildColumn(columnName, columns[columnName]!);
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildColumn(String columnName, List<TaskItem> items) {
    return Container(
      width: 300,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      // Column wrapping the header and the items list
      child: Column(
        mainAxisSize:
            MainAxisSize.min, // This makes the column hug its children
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: _getColumnColor(columnName),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            child: Text(
              columnName,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // The Drop Target area for the whole column
          DragTarget<Map<String, dynamic>>(
            onWillAcceptWithDetails: (details) => true,
            onAcceptWithDetails: (details) {
              _handleMove(details.data, columnName, items.length);
            },
            builder: (context, candidateData, rejectedData) {
              return Container(
                // Minimum height so you can still drop into an empty column
                constraints: const BoxConstraints(minHeight: 100),
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...items.asMap().entries.map((entry) {
                      return _buildDraggableCard(
                        entry.value,
                        columnName,
                        entry.key,
                      );
                    }),
                    // Invisible area to handle drops at the very bottom
                    if (candidateData.isNotEmpty)
                      Container(
                        height: 50,
                        margin: const EdgeInsets.only(top: 8),
                        color: Colors.blue.withOpacity(0.2),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDraggableCard(TaskItem item, String columnName, int index) {
    final Map<String, dynamic> data = {
      'item': item,
      'sourceColumn': columnName,
      'sourceIndex': index,
    };

    return DragTarget<Map<String, dynamic>>(
      onWillAcceptWithDetails: (details) => true,
      onAcceptWithDetails: (details) {
        _handleMove(details.data, columnName, index);
      },
      builder: (context, candidateData, rejectedData) {
        return Column(
          children: [
            // Highlight area when hovering over a card
            if (candidateData.isNotEmpty)
              Container(
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 4),
                color: Colors.blue,
              ),

            Draggable<Map<String, dynamic>>(
              data: data,
              feedback: Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 280,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: item.color.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    item.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              childWhenDragging: Opacity(opacity: 0.2, child: _cardUI(item)),
              child: _cardUI(item),
            ),
          ],
        );
      },
    );
  }

  Widget _cardUI(TaskItem item) {
    return Card(
      elevation: 2,
      color: item.color,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(
          item.title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(Icons.drag_handle, color: Colors.black45),
      ),
    );
  }

  void _handleMove(
    Map<String, dynamic> data,
    String targetColumn,
    int targetIndex,
  ) {
    final TaskItem item = data['item'];
    final String sourceColumn = data['sourceColumn'];

    setState(() {
      // Logic to prevent index errors when moving in the same column
      columns[sourceColumn]!.removeWhere((element) => element.id == item.id);

      int actualInsertIndex = targetIndex;
      if (actualInsertIndex > columns[targetColumn]!.length) {
        actualInsertIndex = columns[targetColumn]!.length;
      }

      columns[targetColumn]!.insert(actualInsertIndex, item);
    });
  }

  Color _getColumnColor(String name) {
    if (name == 'مكتمل') return Colors.green.shade700;
    if (name == 'قيد التنفيذ') return Colors.orange.shade700;
    return Colors.blue.shade700;
  }
}
