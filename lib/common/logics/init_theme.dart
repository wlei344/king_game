
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:king_game/common/common.dart';

Future<void> initTheme() async {
  // 初始化主题
  if(!kIsWeb && GetPlatform.isAndroid) {
    MyTheme.removeNavigationBar();
    MyTheme.setPreferredOrientations();
    MyTheme.setSystemUIOverlayStyle(Brightness.light);
  }
}