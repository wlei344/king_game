import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_game/common/common.dart';

class MyTurntable extends StatefulWidget {
  const MyTurntable({
    super.key,
    required this.onSetReward,
    required this.prizes,
    this.onResult,
    this.onError,
  });

  final Future<int?> Function() onSetReward;
  final void Function(int)? onResult;
  final void Function()? onError;
  final TurntablePrizeListModel prizes;

  @override
  State<MyTurntable> createState() => MyTurntableState();
}

class MyTurntableState extends State<MyTurntable> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animationSpinner;

  int? _index;
  bool _isSpinning = false;

  void spin() {
    _handleGo();
  }

  @override
  void initState() {
    super.initState();

    // 初始化 controller
    _animationController = AnimationController(vsync: this);

    // 初始化 animation
    _animationSpinner = Tween<double>(
      begin: 0,
      end: 0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    ));
  }

  @override
  void dispose() {
    _animationController.stop();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _startSpin(double duration, int rounds, double angle, Curve curve) async {
    _animationController.duration = Duration(milliseconds: (duration * 1000).toInt());
    _animationSpinner = Tween<double>(
      begin: 0,
      end: rounds * 2 * math.pi + angle * math.pi / 180,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: curve,
    ));
    _animationController.reset();
    await _animationController.forward();
  }

  Future<void> _onSetReward() async {
    int length = 6;
    final index = await widget.onSetReward();
    if (index == null || index > length) {
      widget.onError?.call();
      _animationController.stop();
      _animationController.reset();
      _isSpinning = false;
      return;
    } else {
      _index = index;

      final angleEach = 360 / length;
      // final startAngleRad = index * angleEach + angleEach / 6;
      // final sweepAngleRad = (index + 1) * angleEach - angleEach / 6;
      // final random = math.Random();

      final angle = (index - 1) * angleEach;

      await _startSpin(8, 7, 360 - angle, Curves.easeOutExpo);
      _index = null;
      _isSpinning = false;
      widget.onResult?.call(index);
    }
  }

  Future<void> _handleGo() async {
    if (_isSpinning) {
      log('正转着呢，急个啥...');
      MyAlert.showSnack(child: Text(Lang.turntableIsTurning.tr, style: TextStyle(color: Colors.white)));
      return;
    }

    _isSpinning = true;
    _onSetReward();
    while (_index == null) {
      await _startSpin(1, 6, 0, Curves.linear);
    }
  }

  @override
  Widget build(BuildContext context) {
    final turntable = AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => Transform.rotate(
        angle: _animationSpinner.value,
        child: Stack(alignment: Alignment.center, children: [
          MyIcons.lotteryBody,
          Positioned.fill(
            child: CustomPaint(size: Size(double.infinity , double.infinity), painter: MyCustomPainter(
              data: widget.prizes,
            ))
          ),
        ]),
      ),
    );

    final body = Stack(clipBehavior: Clip.none, children: [
      MyIcons.lotteryTurntable,
      Positioned(left: 14, top: 14, right: 14, bottom: 14, child: turntable),
      Positioned(left: -14, top: -14, right: -14, bottom: -14, child: LayoutBuilder(builder: (context, constraints) {
        return Container(
          constraints: constraints,
          child: Align(alignment: Alignment.topCenter, child: SizedBox(height: constraints.maxHeight / 1.6, child: MyIcons.lotteryPointer)),
        );
        // return MyButton(isDebounce: false, onPressed: _handleGo, child: child);
      })),
    ]);

    return Padding(padding: EdgeInsets.all(14), child: body);
  }
}



class MyCustomPainter extends CustomPainter {

  final TurntablePrizeListModel data;

  MyCustomPainter({required this.data});

  @override
  void paint(Canvas canvas, Size size) {
    final angle = 360 / data.list.length;
    data.list.asMap().entries.forEach((e) {
      final index = e.key;
      final item = e.value;
      final startAngleRad = (index * angle - 120) * math.pi / 180;
      final sweepAngleRad = angle * math.pi / 180;

      _drawText(
        canvas: canvas,
        size: size,
        radius: size.width / 2 - size.width * 20 / 320,
        angle: startAngleRad + sweepAngleRad / 2,
        text: '${item.amount}${Lang.points.tr}',
      );
    });
  }

  void _drawText({
    required Canvas canvas,
    required Size size,
    required double radius,
    required double angle,
    String? text,
  }) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'Sans',
          fontWeight: FontWeight.bold,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 4
            ..color = Colors.black,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final textCenter = Offset(
      size.width / 2 + radius * math.cos(angle),
      size.height / 2 + radius * math.sin(angle),
    );

    canvas.save();
    canvas.translate(textCenter.dx, textCenter.dy);
    canvas.rotate(angle + math.pi / 2);

    textPainter.paint(
      canvas,
      Offset(-textPainter.width / 2, -textPainter.height / 2),
    );
    canvas.restore();

    final filledTextPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'Sans',
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    canvas.save();
    canvas.translate(textCenter.dx, textCenter.dy);
    canvas.rotate(angle + math.pi / 2);

    filledTextPainter.paint(
      canvas,
      Offset(-filledTextPainter.width / 2, -filledTextPainter.height / 2),
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
