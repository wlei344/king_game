import 'package:get/get.dart';
import 'package:king_game/common/common.dart';

class LoginState {
  String title = 'Login View';

  LoginModel loginModel = LoginModel.empty();

  final _captchaCountdown = 60.obs;
  int get captchaCountdown => _captchaCountdown.value;
  set captchaCountdown(int value) => _captchaCountdown.value = value;

  ConfigModel config = ConfigModel.empty();
}
