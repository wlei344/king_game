import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:king_game/common/common.dart';

class MiddlewareIndex extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return RouteSettings(name: MyRoutes.login); // 测试时取消 redirect
  }
}
