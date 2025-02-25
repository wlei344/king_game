import 'package:flutter/material.dart';

Widget buildTextField({
  required String hintText,
  required TextEditingController controller,
  EdgeInsetsGeometry? margin,
  Widget? prefixIcon,
  Widget? suffixIcon,
  double height = 55.0,
  TextInputType keyboardType = TextInputType.number,
  TextAlign textAlign = TextAlign.start,
  int? minLines,
  int maxLines = 1,
  int? maxLength,
}) {
  final borderRadius = BorderRadius.circular(10);

  final textField = TextField(
    minLines: minLines,
    maxLines: maxLines,
    maxLength: maxLength,
    controller: controller,
    textAlignVertical: TextAlignVertical.center,
    keyboardType: keyboardType,
    textAlign: textAlign,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      hintText: hintText,
      border: InputBorder.none,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      hintStyle: TextStyle(
        color: const Color(0xFF000000).withValues(alpha: 0.3),
        fontWeight: FontWeight.w600,
        fontSize: 14,
        fontFamily: 'PingFang SC',
      ),
    ),
  );

  return Container(
    margin: margin,
    height: height,
    decoration: BoxDecoration(
      color: Color(0XFFDDDDDD),
      borderRadius: borderRadius,
      border: Border.all(color: Colors.black, width: 2),
    ),
    clipBehavior: Clip.antiAlias,
    child: LayoutBuilder(builder: (context, constraints) => Align(alignment: Alignment.topLeft, child: Container(
      width: constraints.maxWidth,
      height: constraints.maxHeight - 4,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius * 0.8,
      ),
      child: textField,
    ))),
  );
}