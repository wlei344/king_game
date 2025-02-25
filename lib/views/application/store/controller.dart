import 'package:get/get.dart';

import 'state.dart';

class StoreController extends GetxController {
  final state = StoreState();

  @override
  void onReady() async {
    super.onReady();
    
    await getSkins();
  }

  Future<void> getSkins() async {
    await state.skins.value.update();
    state.skins.refresh();
  }
}
