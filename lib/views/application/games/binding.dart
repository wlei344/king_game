import 'package:get/get.dart';

import 'controller.dart';

class GamesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GamesController>(() => GamesController());
  }
}
