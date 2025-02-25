import 'package:get/get.dart';

import 'state.dart';

class BagController extends GetxController {
  final state = BagState();

  @override
  void onReady() async {
    super.onReady();
    
    await getSkins();
  }

  Future<void> getSkins() async {
    await state.bagItems.value.update();
    state.bagItems.refresh();
  }
}
