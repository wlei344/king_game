import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_game/common/common.dart';
import 'package:my_device_info/my_device_info.dart';

import 'state.dart';

class LoginController extends GetxController {
  final state = LoginState();

  final accountController = TextEditingController();
  final accountFocusNode = FocusNode();

  final codeController = TextEditingController();
  final codeFocusNode = FocusNode();

  Timer? timer;

  @override
  Future<void> onReady() async {
    super.onReady();
    await Future.delayed(MyConfig.time.pageTransition);
    await getData();
  }

  Future<void> getData() async {
    await state.config.update();
  }

  void sendCode() async {
    MyAudio.play(MyAudioPath.click);
    if (accountController.text.isEmpty) {
      MyAlert.showSnack(child: Text(Lang.loginViewPhoneEmptyAlert.tr, style: TextStyle(color: Colors.white)));
      return;
    }

    await UserController.to.myDio?.post(MyApi.base.sendPhoneCode,
      data: {
        'mobile': accountController.text,
      },
      onSuccess: (code, msg, data) {
        MyAlert.showSnack(child: Text(Lang.loginViewSendCodeSuccess.tr, style: TextStyle(color: Colors.white)));

        timer?.cancel();
        state.captchaCountdown = 60;
        timer = Timer.periodic(Duration(seconds: 1), (t) {
          if (state.captchaCountdown > 1) {
            state.captchaCountdown--;
          } else {
            t.cancel();
            timer = null;
            state.captchaCountdown = 60;
          }
        });
      },

      onError: (e) {
        MyAlert.showSnack(child: Text('${e.error}', style: TextStyle(color: Colors.white)));
      }
    );
  }

  void onLogin() async {
    if (accountController.text.isEmpty) {
      MyAlert.showSnack(child: Text(Lang.loginViewPhoneEmptyAlert.tr, style: TextStyle(color: Colors.white)));
      return;
    }

    if (codeController.text.isEmpty) {
      MyAlert.showSnack(child: Text(Lang.loginViewCodeEmptyAlert.tr, style: TextStyle(color: Colors.white)));
      return;
    }
    showMyLoading();
    await state.loginModel.login(
      account: accountController.text,
      code: codeController.text,
      onSuccess: () async {
        await loginSuccessful();
      },
      onError: (e) => loginError(e),
    );
  }

  Future<void> loginSuccessful() async {
    UserController.to.userToken = state.loginModel.token;
    setMyDioAddToken();
    await UserController.to.updateUserInfo(
      onSuccess: () {
        Get.toNamed(MyRoutes.application);
        hideMyLoading();
      },
      onError: (e) => loginError(e),
    );
  }

  void loginError(String error) {
    MyAlert.showSnack(child: Text(error, style: TextStyle(color: Colors.white)));
    hideMyLoading();
  }

  void onGuestLogin() async {
    showMyLoading();

    final info = await MyDeviceInfo.getDeviceInfo();
    String device = '${info.brand}, ${info.id}, ${info.model}, ${info.systemVersion}';

    if (kIsWeb) {
      device = '浏览器';
    }

    await state.loginModel.guestLogin(
      deviceId: device,
      onSuccess: () async {
        await loginSuccessful();
      },
      onError: (e) => loginError(e),
    );
  }

  void onLoginForGoogle() {
    MyAlert.showSnack(child: Text(Lang.debug.tr, style: TextStyle(color: Colors.white)));
  }

  void onLoginForFacebook() {
    MyAlert.showSnack(child: Text(Lang.debug.tr, style: TextStyle(color: Colors.white)));
  }
}
