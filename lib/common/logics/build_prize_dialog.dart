import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> buildPrizeDialog({
  Widget? child,
}) async {
  return Get.generalDialog<dynamic>(
    barrierLabel: '',
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: GestureDetector(
              onTap: () {
                // MyAudio.play(MyAudioPath.click);
                Get.back();
              },
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withValues(alpha: 0.5),
              ),
            ),
          ),
          Center(
            child: SafeArea(
              child: Material(
                color: Colors.transparent,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: Get.height * 0.8,
                  ),
                  child: child,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

class AnimatedChildWidget extends StatefulWidget {
  final Widget child;

  const AnimatedChildWidget({super.key, required this.child});

  @override
  AnimatedChildWidgetState createState() => AnimatedChildWidgetState();
}

class AnimatedChildWidgetState extends State<AnimatedChildWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
      upperBound: 1.0,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticInOut),
    );

    _offsetAnimation = Tween<Offset>(begin: Offset(0, 0), end: Offset(0.05, 0.05)).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.identity()
            ..scale(_scaleAnimation.value)
            ..translate(_offsetAnimation.value.dx * 100, _offsetAnimation.value.dy * 100),
          alignment: Alignment.center,
          child: widget.child,
        );
      },
    );
  }
}
