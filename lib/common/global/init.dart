import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_game/common/common.dart';

Future<void> initialized() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 应用初始化
  WidgetsBinding.instance.addPostFrameCallback((duration) {
    // 初始化主题
    initTheme();
    // 初始化语言
    initLang();
    // 初始化音效
    initAudio();
    // 初始化动画
    initSpine();
    // 配置dio
    setMyDio(baseUrl: MyConfig.urls.apiBaseUrl);
  });

  // 导入用户控制器
  await Get.put(UserController()).initComplete;
}



