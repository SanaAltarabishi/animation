import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sidebar_ui/menuItem.dart';

// have to state open and close

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  late AnimationController _animationController;
  late StreamController<bool> isSideBarOpenStreamController;
  late Stream<bool> isSidebarOpenedStream;
  late StreamSink<bool> isSidebarOpenedSink;// to add events to the stream 
  // bool isSideBarOpen = false;
  final _animationDuration = const Duration(milliseconds: 500);
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    isSideBarOpenStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSideBarOpenStreamController.stream;
    isSidebarOpenedSink = isSideBarOpenStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSideBarOpenStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void onIconPress() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;
    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reset();
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, snapshot) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: snapshot.data! ? 0 : -screenWidth,
          //(snapshot.hasData == true) ? 0 : -screenWidth,
          right: snapshot.data! ? 0 : screenWidth - 45, //the container is 35
          child: Row(
            children: [
              Expanded(
                child: Container(
                  color: const Color(0xff262aaa),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        title: Text(
                          'Sana',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        subtitle: Text(
                          'bla bla',
                          style: TextStyle(
                            color: Color(0xff1bb5fd),
                            fontSize: 20,
                          ),
                        ),
                        leading: CircleAvatar(
                          radius: 20,
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Divider(
                        height: 64,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.3),
                        indent: 16,
                        endIndent: 16,
                      ),
                      MenuItem(
                        icon: Icons.home,
                        title: 'Home',
                      ),
                      MenuItem(
                        icon: Icons.accessibility_new_sharp,
                        title: 'Person',
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0, -1),
                child: GestureDetector(
                  onTap: () {
                    onIconPress();
                  },
                  child: ClipPath(
                    clipper: CustomMenuCliper(),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      width: 35,
                      height: 110,
                      color: const Color(0xff262aaa),
                      child: AnimatedIcon(
                        icon: AnimatedIcons.menu_close,
                        progress: _animationController.view,
                        color: const Color(0xff1bb5fd),
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomMenuCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);

    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 9, 0, height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
