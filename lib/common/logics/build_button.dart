import 'package:flutter/material.dart';
import 'package:king_game/common/common.dart';

Widget buildButton({
  void Function()? onPressed,
  EdgeInsetsGeometry? margin,
  required double height,
  required Color shadowColor,
  required List<Color> colors,
  Widget? child,
  bool isPlayAudio = true,
}) {
  final borderRadius = BorderRadius.circular(10);

  final body = Container(
    margin: margin,
    height: height,
    decoration: BoxDecoration(
        color: shadowColor,
        borderRadius: borderRadius,
        border: Border.all(color: Colors.black, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(0, 2),
          ),
        ]
    ),
    clipBehavior: Clip.antiAlias,
    child: LayoutBuilder(builder: (context, constraints) => Stack(alignment: AlignmentDirectional.topCenter, children: [
      Container(
        height: constraints.maxHeight - 4,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: borderRadius * 0.8,
        ),
        child: SingleChildScrollView(padding: EdgeInsets.fromLTRB(4, 4, 4, 0), child: Container(
          alignment: Alignment.topLeft,
          width: constraints.maxWidth,
          height: (constraints.maxHeight - 4) / 2,
          decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.3),
              borderRadius: BorderRadius.only(
                topLeft: borderRadius.copyWith().topLeft,
                topRight: borderRadius.copyWith().topRight,
              ),
              shape: BoxShape.rectangle
          ),
          clipBehavior: Clip.antiAlias,
          child: Container(
            height: 8,
            width: 8,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.8),
              shape: BoxShape.circle,
            ),
          ),
        )),
        // child: textField,
      ),
      Positioned.fill( child: Center(child: child))
    ])),
  );

  return MyButton(onPressed: onPressed, child: body);
}