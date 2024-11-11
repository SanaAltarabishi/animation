import 'package:flutter/material.dart';

class ButtonLinearAnimation extends StatelessWidget {
  const ButtonLinearAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MyButtonWidget(
              color: Colors.pink,
              child: Text(
                "Click",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            MyButtonWidget(
              color: Colors.black,
              child: Text(
                "Click",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            MyButtonWidget(
              color: Colors.orangeAccent,
              child: Text(
                "Click",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
//shopping button :
            ShoppingCartButton(),
          ],
        ),
      ),
    );
  }
}

class ShoppingCartButton extends StatefulWidget {
  const ShoppingCartButton({
    super.key,
  });

  @override
  State<ShoppingCartButton> createState() => _ShoppingCartButtonState();
}

class _ShoppingCartButtonState extends State<ShoppingCartButton> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 800),
        height: 70,
        width: isExpanded ? 220 : 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isExpanded ? 50 : 10),
          color: isExpanded ? Colors.green : Colors.purple,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isExpanded)
              const SizedBox(
                width: 35,
              ),
            Icon(
              isExpanded ? Icons.check : Icons.shopping_cart,
              size: 30,
              color: Colors.white,
            ),
            if (isExpanded)
              const Expanded(
                child: Text(
                  "Add to Cart ",
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class MyButtonWidget extends StatefulWidget {
  final Color color;
  final Widget child;

  const MyButtonWidget({super.key, required this.color, required this.child});

  @override
  State<MyButtonWidget> createState() => _MyButtonWidgetState();
}

class _MyButtonWidgetState extends State<MyButtonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          width: 200,
          height: 100,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                Colors.purple,
                widget.color,
                Colors.blue,
              ],
              stops: [
                0.0,
                _animationController.value,
                1.0,
              ],
            ),
          ),
          child: widget.child,
        );
      },
    );
  }
}
