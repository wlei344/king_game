import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_game/common/common.dart';
import 'package:my_device_info/my_device_info.dart';

Future<void> setMyDio({
  required String baseUrl,
}) async {
  final info = await MyDeviceInfo.getDeviceInfo();
  String device = '${info.brand}, ${info.id}, ${info.model}, ${info.systemVersion}';
  UserController.to.myDio = MyDio(
    baseOptions: (option) => option.copyWith(
      baseUrl: baseUrl,
      connectTimeout: MyConfig.time.outDefault,
      receiveTimeout: MyConfig.time.outDefault,
      sendTimeout: MyConfig.time.outDefault,
    ),
    headers: {
      'token': UserController.to.userToken,
      'device': device,
      'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
    },
    onResponse: (response) async {
      if (response.data is Map<String, dynamic>) {
        final responseModel = ResponseModel.fromJson(response.data);
        if ([401].contains(responseModel.code)) {
          MyAlert.showSnack(child: Text(Lang.tokenExpired.tr, style: TextStyle(color: Colors.white)));
          onLogOUt();
        }
      }
    },
    dioCode: 0,
  );
}

void setMyDioAddToken() {
  UserController.to.myDio?.headers?['token'] = UserController.to.userToken;
}

void setMyDioClearToken() {
  UserController.to.myDio?.headers?['token'] = '';
}