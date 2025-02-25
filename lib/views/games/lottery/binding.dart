import 'package:get/get.dart';

import 'controller.dart';

class LotteryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LotteryController>(() => LotteryController());
  }
}
