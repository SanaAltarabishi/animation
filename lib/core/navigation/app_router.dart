import 'package:evaluate_slider_ex/pages/slider_page.dart';
import 'package:evaluate_slider_ex/slider_provider.dart';
import 'package:evaluate_slider_ex/pages/submit_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => const CustomTransitionPage(
          child: SliderAnimationPage(),
          transitionsBuilder: _fadeTransition,
        ),
      ),
      GoRoute(
        path: '/submit',
        pageBuilder: (context, state) {
          final sliderNotifier = state.extra as SliderNotifier;
          return CustomTransitionPage(
            child: SubmitPage(
              sliderNotifier: sliderNotifier,
            ),
            transitionsBuilder: _fadeTransition,
          );
        },
      )
    ],
  );

  static Widget _fadeTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const curve = Curves.easeInOut;
    var fadeTween = Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));
    return FadeTransition(
      opacity: animation.drive(fadeTween),
      child: child,
    );
  }
}
