import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_game/common/common.dart';
import 'package:spine_flutter/spine_flutter.dart' as spine;
import 'state.dart';

class LotteryController extends GetxController with GetSingleTickerProviderStateMixin {
  final state = LotteryState();

  final spine.SpineWidgetController leftBabyController = spine.SpineWidgetController(onInitialized: (controller) {
    controller.animationState.setAnimationByName(0, "animation", true);
  });

  final spine.SpineWidgetController rightBabyController = spine.SpineWidgetController(onInitialized: (controller) {
    controller.animationState.setAnimationByName(0, "animation", true);
  });

  final spine.SpineWidgetController caidaiController = spine.SpineWidgetController(onInitialized: (controller) {
    controller.animationState.setAnimationByName(0, "animation", false);
  });

  final spine.SpineWidgetController baoxiangController = spine.SpineWidgetController(onInitialized: ( controller) {
    controller.animationState.setAnimationByName(0, "animation", false);
  });

  void _boxSuccess(SkinModel skinData) {
    MyAudio.play(MyAudioPath.exchangeSuccessful);
    buildPrizeDialog(child: Column(mainAxisSize: MainAxisSize.min, children: [
      MyStrokeText(
        text: Lang.price.tr,
        fontFamily: "Sans",
        fontSize: 20,
        strokeWidth: 4,
        dy: 4,
      ),
      Stack(children: [
        MyIcons.alertBackground,
        Positioned.fill(child: Center(child: SizedBox(width: 150, child: AnimatedChildWidget(child: buildSkinItem(skinData: skinData)))))
      ]),
      Row(children: [
        SizedBox(width: 64),
        Expanded(child: buildButton(
          isPlayAudio: false,
          onPressed: () {
            Get.back();
          },
          height: 44,
          colors: [Color(0xFFFBAC17), Color(0xFFFBAC17)],
          shadowColor: Color(0xFF944600),
          child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(height: 30, child: MyIcons.gameTitle(1)),
            SizedBox(width: 10),
            Flexible(child: FittedBox(child: MyStrokeText(
              text: Lang.confirm.tr,
              strokeWidth: 4,
              dy: 3,
              fontFamily: 'Sans',
              fontSize: 13,
            ))),
            SizedBox(width: 8),
          ])),
        )),
        SizedBox(width: 8),
        Expanded(child: buildButton(
          isPlayAudio: false,
          onPressed: () {
            Get.back();
            Get.toNamed(MyRoutes.bag);
          },
          height: 44,
          colors: [Color(0xFFF96312), Color(0xFFF96312)],
          shadowColor: Color(0xFF944600),
          child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(height: 30, child: MyIcons.bag),
            SizedBox(width: 6),
            Flexible(child: FittedBox(child: MyStrokeText(
              text: Lang.check.tr,
              strokeWidth: 4,
              dy: 3,
              fontFamily: 'Sans',
              fontSize: 13,
            ))),
            SizedBox(width: 8),
          ])),
        )),
        SizedBox(width: 64),
      ]),

      SizedBox(height: 8),
      MyStrokeText(
        text: Lang.exchangeSuccessInfo.tr,
        strokeWidth: 4,
        dy: 3,
        fontSize: 14,
      ),
    ]));
  }

  void boxListener() {
    final entry = baoxiangController.animationState.setAnimationByName(0, "animation", true);
    entry.setListener((type, trackEntry, event) async {
      if (type == spine.EventType.start) {
        debugPrint('open chest');
        baoxiangController.pause();
      } else if (type == spine.EventType.complete) {
        baoxiangController.skeleton.setToSetupPose();
        baoxiangController.pause();
        state.isOpeningBox = false;
        if (state.skin.prize.id != -1) {
          _boxSuccess(state.skin.prize);
          UserController.to.userInfo.value.update().then((value) {
            UserController.to.userInfo.refresh();
          });
        } else {
          MyAlert.showSnack(child: Text(Lang.boxEmpty.tr, style: TextStyle(color: Colors.white)));
        }
      }
    });
  }



  final GlobalKey<MyTurntableState> turntableKey = GlobalKey<MyTurntableState>();

  void onStartSpine() {
    turntableKey.currentState?.spin();
  }

  void onOpenBox() async {
    if (state.isOpeningBox) {
      MyAlert.showSnack(child: Text(Lang.openingBox.tr, style: TextStyle(color: Colors.white)));
      return;
    }
    state.isOpeningBox = true;
    state.isDisabled = true;
    baoxiangController.resume();
    await state.skin.update(state.boxIndex);
  }

  @override
  void onReady() async {
    super.onReady();
    await state.turntablePrizes.value.update(1);
    state.turntablePrizes.refresh();
    state.isDisabled = false;
    boxListener();
  }
}
