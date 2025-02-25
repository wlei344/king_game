import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_game/common/common.dart';

Widget buildBack({
  required Widget child,
  Color? color
}) {
  return Container(
    height: 50,
    decoration: BoxDecoration(
      color: color ?? Colors.black.withValues(alpha: 0.5),
    ),
    child: Row(children: [
      MyButton(onPressed: () => Get.back(), child: MyIcons.back),
      Expanded(child: child),
    ],),
  );
}