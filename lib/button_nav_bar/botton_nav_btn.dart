import 'package:custom_transition/button_nav_bar/size_config.dart';
import 'package:flutter/material.dart';

class BottonNavBtn extends StatelessWidget {
  final IconData icon;
  final int index;
  final int currentIndex;
  final Function(int) onPressed;
  const BottonNavBtn({
    super.key,
    required this.icon,
    required this.index,
    required this.currentIndex,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    AppSize().initState(context);
    return Container(
      height: AppSize.blockSizeHorizontal * 13,
      width: AppSize.blockSizeHorizontal * 17,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: InkWell(
        onTap: () {
          onPressed(index);
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            (currentIndex == index)
                ? Positioned(
                    left: AppSize.blockSizeHorizontal * 4,
                    bottom: AppSize.blockSizeHorizontal * 1.5,
                    child: Icon(
                      icon,
                      color: Colors.black,
                      size: AppSize.blockSizeHorizontal * 8,
                    ),
                  )
                : Container(),
            AnimatedOpacity(
              opacity: (currentIndex == index) ? 1 : 0.1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
              child: Icon(
                icon,
                color: Colors.yellow[300],
                size: AppSize.blockSizeHorizontal * 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
