import 'package:custom_transition/button_nav_bar/botton_nav_btn.dart';
import 'package:custom_transition/button_nav_bar/clipper.dart';
import 'package:custom_transition/button_nav_bar/constants.dart';
import 'package:custom_transition/button_nav_bar/size_config.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class FinalView extends StatefulWidget {
  const FinalView({super.key});

  @override
  State<FinalView> createState() => _FinalViewState();
}

class _FinalViewState extends State<FinalView> {
  int _currentIndex = 0;
  late final PageController pageController;

  get curve => null;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void animateToPage(int page) {
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.decelerate,
    );
  }

  @override
  Widget build(BuildContext context) {
    AppSize().initState(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        title: const Text(
          'Custom Botton Navigation Bar',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Positioned.fill(
              child: PageView(
                controller: pageController,
                children: screens,
                onPageChanged: (value) {
                  setState(() {
                    _currentIndex = value;
                  });
                },
              ),
            ),
            Positioned(
              bottom: -30,
              right: 0,
              left: 0,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  AppSize.blockSizeHorizontal * 4.5,
                  0,
                  AppSize.blockSizeHorizontal * 4.5,
                  70,
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.transparent,
                  elevation: 10,
                  child: Container(
                    width: AppSize.screenWidth,
                    height: AppSize.blockSizeHorizontal * 18,
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          top: 0,
                          left: AppSize.blockSizeHorizontal * 3,
                          right: AppSize.blockSizeHorizontal * 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              BottonNavBtn(
                                icon: IconlyLight.home,
                                currentIndex: _currentIndex,
                                index: 0,
                                onPressed: (val) {
                                  animateToPage(val);
                                  setState(() {
                                    _currentIndex = val;
                                  });
                                },
                              ),
                              BottonNavBtn(
                                icon: IconlyLight.search,
                                currentIndex: _currentIndex,
                                index: 1,
                                onPressed: (val) {
                                  animateToPage(val);
                                  setState(() {
                                    _currentIndex = val;
                                  });
                                },
                              ),
                              BottonNavBtn(
                                icon: IconlyLight.category,
                                currentIndex: _currentIndex,
                                index: 2,
                                onPressed: (val) {
                                  animateToPage(val);
                                  setState(() {
                                    _currentIndex = val;
                                  });
                                },
                              ),
                              BottonNavBtn(
                                icon: IconlyLight.setting,
                                currentIndex: _currentIndex,
                                index: 3,
                                onPressed: (val) {
                                  animateToPage(val);
                                  setState(
                                    () {
                                      _currentIndex = val;
                                    },
                                  );
                                },
                              ),
                              BottonNavBtn(
                                icon: IconlyLight.profile,
                                currentIndex: _currentIndex,
                                index: 4,
                                onPressed: (val) {
                                  animateToPage(val);
                                  setState(
                                    () {
                                      _currentIndex = val;
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        AnimatedPositioned(
                          curve: Curves.decelerate,
                          left: animatedPositionedLeftValue(_currentIndex),
                          duration: const Duration(milliseconds: 300),
                          child: Column(
                            children: [
                              Container(
                                height: AppSize.blockSizeHorizontal * 1.0,
                                width: AppSize.blockSizeHorizontal * 12,
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              ClipPath(
                                clipper: MyCustomClipper(),
                                child: Container(
                                  height: AppSize.blockSizeHorizontal * 15,
                                  width: AppSize.blockSizeHorizontal * 12,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: gradient,
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
