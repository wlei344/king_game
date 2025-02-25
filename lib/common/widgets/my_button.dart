import 'dart:async';
import 'package:flutter/material.dart';
import 'package:king_game/common/common.dart';
import 'package:get/get.dart';

class MyButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool isDebounce;

  const MyButton({
    super.key,
    required this.child,
    this.onPressed,
    this.isDebounce = true,
  });

  @override
  CustomButtonState createState() => CustomButtonState();
}

class CustomButtonState extends State<MyButton> {
  double _opacity = 1.0;
  Timer? _debounceTimer;
  bool _isClickable = true;

  void _setOpacity(double opacity) {
    if (mounted) {
      setState(() {
        _opacity = opacity;
      });
    }
  }

  void _onTapDown(TapDownDetails details) {
    if (!_isClickable) return;
    _setOpacity(0.75);
  }

  void _onTapUp(TapUpDetails details) {
    if (!_isClickable) return;
    _setOpacity(1.0);
  }

  void _onTapCancel() {
    if (!_isClickable) return;
    _setOpacity(1.0);
  }

  void _onPressed() {
    if (!_isClickable || widget.onPressed == null) return;

    Get.focusScope?.unfocus();

    MyAudio.play(MyAudioPath.click);

    widget.onPressed?.call();

    if (widget.isDebounce) {
      setState(() {
        _isClickable = false;
        _opacity = 0.5;
      });

      _debounceTimer?.cancel();
      _debounceTimer = Timer(Duration(milliseconds: 1000), () {
        setState(() {
          _isClickable = true;
          _opacity = 1.0;
        });
      });
    }
  }

  void _onMouseEnter(PointerEvent details) {
    if (!_isClickable) return;
    _setOpacity(0.9);
  }

  void _onMouseExit(PointerEvent details) {
    if (!_isClickable) return;
    _setOpacity(1.0);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.onPressed == null) {
      return widget.child;
    }

    return MouseRegion(
      onEnter: _onMouseEnter,
      onExit: _onMouseExit,
      child: GestureDetector(
        onTap: _isClickable ? _onPressed : null,
        onTapDown: _isClickable ? _onTapDown : null,
        onTapUp: _isClickable ? _onTapUp : null,
        onTapCancel: _isClickable ? _onTapCancel : null,
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: Duration(milliseconds: 100),
          child: widget.child,
        ),
      ),
    );
  }
}