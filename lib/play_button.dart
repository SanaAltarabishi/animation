import 'package:button_animation/blob.dart';
import 'package:flutter/material.dart';
import 'dart:math' show pi;

class PlayButton extends StatefulWidget {
  final bool initialIsPlaying;
  final Icon playIcon;
  final Icon pauseIcon;
  final VoidCallback onPressed;
  const PlayButton({
    super.key,
    this.initialIsPlaying = false,
    this.playIcon = const Icon(Icons.play_arrow),
    this.pauseIcon = const Icon(Icons.pause),
    required this.onPressed,
  });

  @override
  State<PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> with TickerProviderStateMixin {
  static const _kToggleDuration = Duration(milliseconds: 300);
  static const _kRotationDuration = Duration(seconds: 5);
  late bool isPlaying;

  late AnimationController _rotationController;
  late AnimationController _scaleController;

  double _rotation = 0;
  double _scale = 0.85;

  bool get _showWaves => !_scaleController.isDismissed;
  @override
  void initState() {
    super.initState();
    isPlaying = widget.initialIsPlaying;
    _rotationController = AnimationController(
      vsync: this,
      duration: _kRotationDuration,
    )
      ..addListener(() => setState(_updateRotation))
      ..repeat();

    _scaleController = AnimationController(
      vsync: this,
      duration: _kToggleDuration,
    )..addListener(() => setState(_updateScale));
  }

  void _updateRotation() => _rotation = _rotationController.value * 2 * pi;

  void _updateScale() => _scale = (_scaleController.value * 0.2) + 0.85;

  void _onToggle() {
    setState(() => isPlaying = !isPlaying);
    if (_scaleController.isCompleted) {
      _scaleController.reverse();
    } else {
      _scaleController.forward();
    }
    widget.onPressed();
  }

  Widget _buildIcon(bool isPlaying) {
    return SizedBox.expand(
      key: ValueKey<bool>(isPlaying),
      child: IconButton(
        onPressed: _onToggle,
        icon: isPlaying ? widget.pauseIcon : widget.playIcon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 48,
        minHeight: 48,
      ),
      child: Stack(
        children: [
          if (_showWaves) ...[
            Blob(
              color: const Color(0xff0092ff),
              scale: _scale,
              roatation: _rotation,
            ),
            Blob(
              color: const Color(0xff4ac7b7),
              scale: _scale,
              roatation: _rotation * 2 - 30,
            ),
            Blob(
              color: const Color(0xffa4a6f6),
              scale: _scale,
              roatation: _rotation * 3 - 45,
            ),
          ],
          Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: AnimatedSwitcher(
                duration: _kToggleDuration, child: _buildIcon(isPlaying)),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _rotationController.dispose();
    super.dispose();
  }
}
