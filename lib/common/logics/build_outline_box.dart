import 'package:flutter/material.dart';

Widget buildOutlineBox({
  Color? color,
  required Color borderColor,
  required double radius,
  double? width,
  double? height,
  required Widget child,
}) {
  return Container(
    padding: EdgeInsets.all(8),
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      border: Border.all(
        color: borderColor,
        width: 1.0,
      ),
      boxShadow: [
        BoxShadow(
          offset: Offset(0, 4),
          blurRadius: 0,
          spreadRadius: 2,
          color: Colors.black.withValues(alpha: 0.5),
        ),
      ],
    ),
    child: IntrinsicHeight(child: Stack(clipBehavior: Clip.none, children: [
      Opacity(opacity: 0, child: child),
      Container(
        padding: EdgeInsets.all(6),
        height: 20,
        decoration: BoxDecoration(
          color: Color(0xFFD9D9D9).withValues(alpha: 0.3),
          borderRadius: BorderRadius.all(Radius.circular(radius * 0.5)),
        ),
      ),
      Positioned(left: 8, right: 8, top: 8, child: child),
    ]))
  );
}