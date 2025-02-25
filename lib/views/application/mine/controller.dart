import 'package:get/get.dart';
import 'package:king_game/common/common.dart';

import 'state.dart';

class MineController extends GetxController {
  final state = MineState();

  void onSetting() {
    buildSettingDialog();
  }

  void onSignIn() {
    buildSignInDialog();
  }

  void onInvite() {
    buildInviteDialog();
  }

  void onBag() {
    // MyAlert.showSnack(child: Text(Lang.debug.tr, style: TextStyle(color: Colors.white)));
    Get.toNamed(MyRoutes.bag);
  }

  void onRecharge() {
    Get.toNamed(MyRoutes.recharge);
  }

  void onExchange() {
    buildExchangeDialog();
  }
}
