import 'package:flutter/material.dart';

class SeveralIcon extends StatefulWidget {
  final String title;
  final int index;
  final IconData icon;
  final Color color;
  final bool isOpen;
  const SeveralIcon(
      {super.key,
      required this.title,
      required this.icon,
      required this.color,
      required this.isOpen,
      required this.index});

  @override
  State<SeveralIcon> createState() => _SeveralIconState();
}

class _SeveralIconState extends State<SeveralIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller; // controller for each item

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));

    // if (widget.isOpen) {
    //   Future.delayed(Duration(milliseconds: widget.index * 200), () {
    //     if (mounted) _controller.forward();
    //   });
    // }
  }

  @override
  void didUpdateWidget(SeveralIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (mounted) {
      if (widget.isOpen) {
        Future.delayed(Duration(milliseconds: widget.index * 200), () {
          if (mounted) _controller.forward();
        });
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _controller.value,
          child: Opacity(
            opacity: _controller.value,
            //? Material here :
            child: InkWell(
              onTap: () {},
              child: Container(
                height: 45,
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: Icon(
                        widget.icon,
                        size: 40,
                        color: widget.color,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
