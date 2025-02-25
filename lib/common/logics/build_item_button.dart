import 'package:flutter/material.dart';

Widget buildItemButton({
  double? width,
  double? height,
  Color? color,
  Color? shadowColor,

  Widget? child,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color,
        border:  Border.all(color: Colors.black, width: 2),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 0,
            spreadRadius: 0,
            color: shadowColor ?? Colors.white.withValues(alpha: 0.2),
          ),
        ]
    ),
    child: child,
  );
}