import 'package:get/get.dart';

import 'controller.dart';

class BagBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BagController>(() => BagController());
  }
}
