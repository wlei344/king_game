import 'package:flutter/cupertino.dart';

class MyStrokeText extends StatelessWidget {
  const MyStrokeText({
    super.key,
    this.text = '',
    this.fontFamily,
    this.fontSize,
    this.fontWeight,
    this.strokeWidth = 3,
    this.strokeColor = const Color(0xFF000000),
    this.textColor = const Color(0xFFFFFFFF),
    this.shadowColor = const Color(0xFF000000),
    this.letterSpacing = 0.0,
    this.dx = 0.0,
    this.dy = 2.5,
    this.overflow,
    this.maxLines,
    this.textAlign,
  });
  final String text;
  final String? fontFamily;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double strokeWidth;
  final Color strokeColor;
  final Color textColor;
  final Color shadowColor;
  final double dx;
  final double dy;
  final double letterSpacing;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        // 描边的文字
        Text(
          text,
          textAlign: textAlign,
          maxLines: maxLines,
          style: TextStyle(
            letterSpacing: letterSpacing,
            fontFamily: fontFamily,
            fontSize: fontSize,
            fontWeight: fontWeight,
            overflow: overflow,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = strokeColor,
          ),
        ),
        // 阴影的文字
        Text(
          text,
          maxLines: maxLines,
          textAlign: textAlign,
          style: TextStyle(
            letterSpacing: letterSpacing,
            fontFamily: fontFamily,
            fontSize: fontSize,
            fontWeight: fontWeight,
            overflow: overflow,
            color: textColor,
            shadows: [
              Shadow(
                color: shadowColor,
                offset: Offset(dx, dy),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
