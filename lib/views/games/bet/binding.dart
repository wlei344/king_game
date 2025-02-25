import 'package:get/get.dart';

import 'controller.dart';

class BetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BetController>(() => BetController());
  }
}
