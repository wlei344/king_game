import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_game/common/common.dart';

import 'controller.dart';

class MineView extends StatelessWidget {
  const MineView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MineController>(
        init: MineController(),
        builder: (controller) {
          return _buildBody(context, controller);
        }
    );
  }

  Widget _buildBody(BuildContext context, MineController controller) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: MyIcons.gameBackground, fit: BoxFit.fill),
        ),
        child: Column(children: [
          buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(height: 20),
                _buildHeaderButtons(context, controller),
                SizedBox(height: 20),
                _buildBodyButtons(context, controller),
                SizedBox(height: 20),
                SizedBox(height: MyConfig.app.bottomHeight),
              ])
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildHeaderButtons(BuildContext context, MineController controller) {
    final height = kIsWeb || Get.width > MyConfig.app.webBodyMaxWidth ? 55.0 : 46.0;
    return Row(children: [
      SizedBox(width: 10),
      Expanded(child: buildButton(
        onPressed: controller.onRecharge,
        shadowColor: Color(0xFF944600),
        colors: [Color(0xFFFFB72E), Color(0xFFFBAC17)],
        height: height,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(height: 30, child: MyIcons.headerStone),
          Flexible(child: FittedBox(child: MyStrokeText(
            text: Lang.mineViewBuyPoints.tr,
            strokeWidth: 3,
            dy: 3,
            fontSize: 15,
            fontFamily: 'Sans',
          ))),
          SizedBox(width: 10),
        ]),
      )),
      SizedBox(width: 2),
      Expanded(child: buildButton(
        onPressed: controller.onExchange,
        shadowColor: Color(0xFF944600),
        colors: [Color(0xFFF96312), Color(0xFFF96312)],
        height: height,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(height: 30, child: MyIcons.headerCard),
          Flexible(child: FittedBox(child: MyStrokeText(
            text: Lang.mineViewRedeemRaffleTickets.tr,
            strokeWidth: 3,
            dy: 3,
            fontSize: 15,
            fontFamily: 'Sans',
          ))),
          SizedBox(width: 10),
        ]),
      )),
      SizedBox(width: 10),
    ]);
  }

  Widget _buildBodyButtons(BuildContext context, MineController controller) {
    final buttons = Column(children: [
      Row(children: [
        SizedBox(width: 10),
        Expanded(child: MyButton(
          onPressed: controller.onBag,
          child: Stack(children: [
            MyIcons.meButtonTopLeft,
            Positioned.fill(bottom: -50, left: 10, right: 10, child: Center(child: FittedBox(child: MyStrokeText(
              text: Lang.mineViewMyBag.tr,
              strokeWidth: 5,
              dy: 3,
              fontFamily: 'Sans',
              fontSize: 17,
            ))))
          ])
        )),
        Expanded(child: MyButton(
          onPressed: controller.onInvite,
          child: Stack(children: [
            MyIcons.meButtonTopRight,
            Positioned.fill(bottom: -50, left: 10, right: 10, child: Center(child: FittedBox(child: MyStrokeText(
              text: Lang.mineViewInviteFriends.tr,
              strokeWidth: 5,
              dy: 3,
              fontFamily: 'Sans',
              fontSize: 17,
            )))),
          ]),
        )),
        SizedBox(width: 10),
      ]),
      Row(children: [
        SizedBox(width: 10),
        Expanded(child: MyButton(
          onPressed: controller.onSignIn,
          child: Stack(children: [
            MyIcons.meButtonBottomLeft,
            Positioned.fill(bottom: -50, left: 10, right: 10, child: Center(child: FittedBox(child: MyStrokeText(
              text: Lang.mineViewDailySignIn.tr,
              strokeWidth: 5,
              dy: 3,
              fontFamily: 'Sans',
              fontSize: 17,
            )))),
          ]),
        )),
        Expanded(child: MyButton(
          onPressed: controller.onSetting,
          child: Stack(children: [
            MyIcons.meButtonBottomRight,
            Positioned.fill(bottom: -50, left: 10, right: 10, child: Center(child: FittedBox(child: MyStrokeText(
              text: Lang.mineViewSetting.tr,
              strokeWidth: 5,
              dy: 5,
              fontFamily: 'Sans',
              fontSize: 17,
            )))),
          ]),
        )),
        SizedBox(width: 10),
      ]),
    ]);
    final body = Stack(children: [
      buttons,
      Positioned(left: 7, right: 7, bottom: -8, child: MyIcons.meButtonBottomIcon)
    ]);
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 10,
            spreadRadius: 2,
            blurStyle: BlurStyle.normal,
            color: Colors.black45,
          )
        ]
      ),
      child: body,
    );
  }
}
