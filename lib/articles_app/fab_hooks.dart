// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FabHooksAnimation extends HookWidget {
  const FabHooksAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    final hideFabAnimController = useAnimationController(
      duration: const Duration(milliseconds: 100),
      initialValue: 1,
    );

    final scrollController =
        useScrollControllerForAnimation(hideFabAnimController);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      floatingActionButton: FadeTransition(
        opacity: hideFabAnimController,
        child: FloatingActionButton.extended(
          onPressed: () {},
          label: const Text('Floating Action button'),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView(
        controller: scrollController,
        children: [
          for (int i = 0; i < 5; i++)
            const Card(
              child: FittedBox(
                child: FlutterLogo(),
              ),
            ),
        ],
      ),
    );
  }
}

// function for scroll:
/*
ScrollController useScrollControllerForAnimation(
    AnimationController animationController) {
  ScrollController scrollController = ScrollController();

  scrollController.addListener(
    () {
      switch (scrollController.position.userScrollDirection) {
        case ScrollDirection.forward:
          animationController.forward();
          break;
        case ScrollDirection.reverse:
          animationController.reverse();
          break;
        case ScrollDirection.idle:
          break;
      }
    },
  );
  return scrollController;
}
*/

class _ScrollControllerForAnimationHook extends Hook<ScrollController> {
  final AnimationController animationController;
  const _ScrollControllerForAnimationHook({
    required this.animationController,
  });

  @override
  _ScrollControllerForAnimationHookState createState() =>
      _ScrollControllerForAnimationHookState();
}

class _ScrollControllerForAnimationHookState
    extends HookState<ScrollController, _ScrollControllerForAnimationHook> {
  late ScrollController _scrollController;

  @override
  void initHook() {
    _scrollController = ScrollController();
    _scrollController.addListener(
      () {
        switch (_scrollController.position.userScrollDirection) {
          case ScrollDirection.forward:
            hook.animationController.forward();
            break;
          case ScrollDirection.reverse:
            hook.animationController.reverse();
            break;
          case ScrollDirection.idle:
            break;
        }
      },
    );
  }

  @override
  ScrollController build(BuildContext context) => _scrollController;

  @override
  void dispose() {
    _scrollController.dispose();
  }
}

ScrollController useScrollControllerForAnimation(
    AnimationController animationController) {
  return use(_ScrollControllerForAnimationHook(
      animationController: animationController));
}
