import 'package:get/get.dart';
import 'package:king_game/common/common.dart';

Future<void> onLogOUt() async {
  UserController.to.myDio?.post(MyApi.base.logout);
  UserController.to.userToken = '';
  UserController.to.userInfo.value = UserModel.empty();
  UserController.to.userInfo.refresh();
  Get.offAllNamed(MyRoutes.login);
}