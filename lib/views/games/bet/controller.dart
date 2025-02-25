import 'package:get/get.dart';
import 'package:king_game/common/models/bet_model.dart';

import 'state.dart';

class BetController extends GetxController {
  final state = BetState();

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      state.betType = Get.arguments;
    }

    if (state.betType == BetType.oddAndEven) {
      state.gameIndex = 1;
    }
  }
}
