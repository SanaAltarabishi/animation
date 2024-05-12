

import 'package:flutter/material.dart';
import 'package:sidebar_ui/sidebar/homePage.dart';
import 'package:sidebar_ui/sidebar/sidebar.dart';

class SideBarLayout extends StatelessWidget {
  const SideBarLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          HomePage(),
          SideBar(),
        ],
      ),
    );
  }
}