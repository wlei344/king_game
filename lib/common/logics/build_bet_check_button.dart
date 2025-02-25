import 'package:flutter/material.dart';
import 'package:king_game/common/common.dart';

Widget buildBetCheckButton({
  required bool isChecked,
  required double height,
  void Function()? onPressed,
  required Widget child,
}) {
  final body = Container(
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: isChecked ? Color(0xFF5380EF) : Color(0xFF112A52),
      border: Border.all(color: Colors.black,  width: 2),
    ),
    child: Stack(children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isChecked ? Color(0xFF5380EF) : Color(0xFF36364A),
        ),
      ),
      if (isChecked)
        Positioned.fill(child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color(0xFF7EA0F3),
          ),
        )),
      if (isChecked)
        Positioned.fill(top: 2, child: Container(
          height: height - 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color(0xFF5380EF),
          ),
        )),
      Positioned.fill(child: child),
    ])
  );

  return MyButton(onPressed: onPressed, isDebounce: false, child: body);
}