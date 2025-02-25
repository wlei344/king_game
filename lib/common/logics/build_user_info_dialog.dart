import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_game/common/common.dart';

Future<void> buildUserInfoDialog() async {
  return showMyDialog(
    header: _buildHeader(),
    body: _buildBody(),
  );
}

Widget _buildHeader() {
  return MyStrokeText(
    text: Lang.userInfoTitle.tr,
    strokeWidth: 4,
    dy: 3,
    fontSize: 20,
    fontFamily: 'Sans',
  );
}

Widget _buildBody() {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: MyIcons.alertBodyBackground,
        repeat: ImageRepeat.repeat,
      ),
    ),
    child: Container(padding: EdgeInsets.fromLTRB(16, MyConfig.app.alertHeaderHeight / 2 + 16, 16, 16), child: SingleChildScrollView(
      child: Column(children: [
        Stack(children: [
          SizedBox(height: 80, child: MyIcons.headerAvatarBackground),
          Positioned.fill(child: Padding(padding: EdgeInsets.fromLTRB(3, 3, 3, 6), child: MyIcons.headerAvatar)),
        ]),

        SizedBox(height: 10),

        Obx(() => MyStrokeText(
          text: UserController.to.userInfo.value.nickname,
          strokeWidth: 4,
          dy: 3,
          fontSize: 18,
          fontFamily: 'Sans',
        )),

        SizedBox(height: 4),

        Obx(() => MyStrokeText(
          text: 'ID: ${UserController.to.userInfo.value.id}',
        )),

        SizedBox(height: 10),

        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color(0xFF36364A),
            border: Border.all(color: Colors.black, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.white12,
                offset: Offset(0, 2),
                // blurRadius: 4,
              ),
            ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => MyStrokeText(
                text: '${Lang.userInfoRealName.tr}: ${UserController.to.userInfo.value.accountName.isEmpty ? Lang.userInfoInputHint.tr : UserController.to.userInfo.value.accountName} | ${UserController.to.userInfo.value.bankName.isEmpty ? Lang.userInfoInputHint.tr : UserController.to.userInfo.value.bankName}',
              )),

              SizedBox(height: 4),

              Obx(() => MyStrokeText(
                text: '${Lang.userInfoBank.tr}: ${UserController.to.userInfo.value.cardNumber.isEmpty ? Lang.userInfoInputHint.tr : UserController.to.userInfo.value.cardNumber}',
              )),
            ],
          ),
        ),

        SizedBox(height: 20),

        MyButton(onPressed: () {
          Get.back();
          buildEditInfoDialog();
        }, isDebounce: false, child: SizedBox(height: 40, child: MyIcons.editUserInfo)),

        SizedBox(height: 10),
      ]),
    )),
  );
}