part of 'theme.dart';

class MyStyles {
  static final MyStyles _instance = MyStyles._internal();
  factory MyStyles() => _instance;
  MyStyles._internal();

  static TextStyle get hintText => TextStyle(
    color: const Color(0xFF000000).withValues(alpha: 0.3),
    fontWeight: FontWeight.w600,
    fontSize: 13,
    fontFamily: 'PingFang SC'
  );
}
