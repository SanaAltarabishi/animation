import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ButtomPage(),
    );
  }
}

class ButtomPage extends StatelessWidget {
  const ButtomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title:const Text('Bottom app'),
      ),
      bottomNavigationBar:const ButtomNavyBar(),
    );
  }
}

class ButtomNavyBar extends StatefulWidget {
  const ButtomNavyBar({super.key});

  @override
  State<ButtomNavyBar> createState() => _ButtomNavyBarState();
}

class _ButtomNavyBarState extends State<ButtomNavyBar> {
  int selectedIndex = 0;
  Color backgroundColor = Colors.white;
  List<NavigationItem> items = [
    NavigationItem(
        icon:const Icon(Icons.home), title:const Text('Home'), color: Colors.purple),
    NavigationItem(
        icon:const Icon(Icons.favorite_border_sharp),
        title:const Text('favourite'),
        color: Colors.blue),
    NavigationItem(
        icon:const Icon(Icons.search), title:const Text('search'), color: Colors.pink),
    NavigationItem(
        icon:const Icon(Icons.person_2_outlined),
        title:const Text('person'),
        color: Colors.green),
    NavigationItem(
        icon:const Icon(Icons.abc), title:const Text('aa'), color: Colors.brown)
  ];

  Widget _buildItem(NavigationItem item, bool isSelect) {
    return AnimatedContainer(
      duration:const Duration(milliseconds: 270),
      // padding:isSelect? EdgeInsets.only(left: 16,right: 16):null,
      height: double.maxFinite,
      width: isSelect ? 120 : 50,
      decoration: isSelect
          ? BoxDecoration(
              color: item.color.withOpacity(0.2),
              borderRadius:const BorderRadius.all(Radius.circular(50)))
          : null,
      child: ListView(
        scrollDirection: Axis.horizontal,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconTheme(
                    data: IconThemeData(
                      size: 24,
                      color: isSelect ? item.color : Colors.black,
                    ),
                    child: item.icon),
                Padding(
                  padding:const EdgeInsets.only(left: 8),
                  child: isSelect ? DefaultTextStyle.merge(
                    style: TextStyle(
                      color: item.color
                    ),
                    child: item.title) : Container(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow:const [BoxShadow(color: Colors.black12, blurRadius: 4)]),
      padding:const EdgeInsets.all(8),
      // color: Color.fromARGB(255, 131, 192, 243),
      width: MediaQuery.of(context).size.width,
      height: 56,
      //! wrap this with singleChild ...
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items.map((item) {
          var itemIndex = items.indexOf(item);
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = itemIndex;
              });
            },
            child: _buildItem(item, selectedIndex == itemIndex),
          );
        }).toList(),
      ),
    );
  }
}

class NavigationItem {
  final Icon icon;
  final Text title;
  final Color color;
  NavigationItem({
    required this.icon,
    required this.title,
    required this.color,
  });
}
