
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_game/common/common.dart';
import 'package:spine_flutter/spine_widget.dart';

import 'controller.dart';

class LotteryView extends GetView<LotteryController> {
  const LotteryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: MyIcons.gameBackground, fit: BoxFit.fill),
          // color: Color(0xFF36374C),
        ),
        child: Column(children: [
          buildHeader(context, bottom:  buildBack(child: Row(children: [
            SizedBox(width: 20),
            SizedBox(height: 30, child: MyIcons.gameTitle(1)),
            SizedBox(width: 8),
            MyStrokeText(
              text: Lang.gameViewRouletteLottery.tr,
              fontSize: 18,
              strokeWidth: 4,
              dy: 3,
              fontFamily: 'Sans',
            )
          ]))),
          Expanded(child: _buildBody(context)),
        ]),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(children: [
      SizedBox(height: 10),

      Row(children: [
        SizedBox(width: 32),
        Expanded(child: MyButton(
          isDebounce: false,
          onPressed: () {
            controller.state.gameIndex = 0;
          },
          child: Stack(children: [
            Obx(() => controller.state.gameIndex == 0 ? MyIcons.lotteryHeaderButton(1) : MyIcons.lotteryHeaderButton(0)),
            Positioned.fill(child: Center(child: FittedBox(child: Center(child: MyStrokeText(
              text: Lang.gameTurntable.tr,
              strokeWidth: 4,
              fontFamily: "Sans",
              fontSize: 13,
              dy: 0,
            )))))
          ]),
        )),
        Expanded(child: MyButton(
          isDebounce: false,
          onPressed: () {
            controller.state.gameIndex = 1;

          },
          child: Stack(children: [
            Obx(() => controller.state.gameIndex == 1 ? MyIcons.lotteryHeaderButton(1) : MyIcons.lotteryHeaderButton(0)),
            Positioned.fill(child: Center(child: FittedBox(child: Center(child: MyStrokeText(
              text: Lang.gameBox.tr,
              strokeWidth: 4,
              fontFamily: "Sans",
              fontSize: 13,
              dy: 0,
            )))))
          ]),
        )),
        SizedBox(width: 32),
      ]),

      Expanded(child: Obx(() => IndexedStack(index: controller.state.gameIndex, children: [
        _buildTurntableView(context),
        _buildBoxView(context),
      ]))),
    ]);
  }

  Widget _buildBoxView(BuildContext context) {
    final child = Column(mainAxisAlignment: MainAxisAlignment.end, children: [

      Stack(clipBehavior: Clip.none, alignment: AlignmentDirectional.center, children: [
        SizedBox(
          height: MyConfig.app.webBodyMaxWidth * 0.4,
          width: MyConfig.app.webBodyMaxWidth * 0.4,
        ),

        Positioned(left: 0 - MyConfig.app.webBodyMaxWidth * 0.2, right: 0 - MyConfig.app.webBodyMaxWidth * 0.67, top: 0 - MyConfig.app.webBodyMaxWidth * 0.82, bottom: 0 - MyConfig.app.webBodyMaxWidth * 0.55, child: SizedBox(
          child: SpineWidget.fromAsset(
            'assets/spine/baoxiang_atlas.atlas',
            'assets/spine/baoxiang_skel.skel',
            controller.baoxiangController,
            fit: BoxFit.cover,
          ),
        )),
      ]),


      const SizedBox(height: 60),

      SafeArea(top: false, child: Column(children: [
        MyButton(isDebounce: false, onPressed: () {
          controller.onOpenBox();
        }, child: _buildTurntableButton()),
        SizedBox(height: 20),
        Row(children: [
          SizedBox(width: 32),
          Expanded(child: Stack(children: [
            MyIcons.lotteryButton0,
            Positioned.fill(left: 10, right: 10, bottom: 10, child: Row(children: [
              Expanded(child: MyButton(isDebounce: false, onPressed: () async {
                controller.state.boxIndex = 1;
                controller.state.isDisabled = true;
              }, child: Stack(children: [
                Obx(() => controller.state.boxIndex == 1
                    ? MyIcons.lotteryButton1
                    : MyIcons.lotteryButton2
                ),
                Positioned.fill(left: 8, right: 8, child: Center(child: FittedBox(child: MyStrokeText(
                  text: Lang.turntableSilver.tr,
                  fontSize: 18,
                  fontFamily: 'Sans',
                  strokeWidth: 4,
                  dy: 0,
                  maxLines: 1,
                )))),
              ]))),
              SizedBox(width: 4),
              Expanded(child: MyButton(isDebounce: false, onPressed: () async {
                controller.state.boxIndex = 2;
                controller.state.isDisabled = true;
              }, child: Stack(children: [
                Obx(() => controller.state.boxIndex == 2
                    ? MyIcons.lotteryButton1
                    : MyIcons.lotteryButton2
                ),
                Positioned.fill(left: 8, right: 8, child: Center(child: FittedBox(child: MyStrokeText(
                  text: Lang.turntableGold.tr,
                  fontSize: 18,
                  fontFamily: 'Sans',
                  strokeWidth: 4,
                  dy: 0,
                  maxLines: 1,
                )))),
              ]))),
              SizedBox(width: 4),
              Expanded(child: MyButton(isDebounce: false, onPressed: () async {
                controller.state.boxIndex = 3;
                controller.state.isDisabled = true;
              }, child: Stack(children: [
                Obx(() => controller.state.boxIndex == 3
                    ? MyIcons.lotteryButton1
                    : MyIcons.lotteryButton2
                ),
                Positioned.fill(left: 8, right: 8, child: Center(child: FittedBox(child: MyStrokeText(
                  text: Lang.turntableDiamond.tr,
                  fontSize: 18,
                  fontFamily: 'Sans',
                  strokeWidth: 4,
                  dy: 0,
                  maxLines: 1,
                )))),
              ])))
            ]))
          ])),
          SizedBox(width: 32),
        ],)
      ])),

      const SizedBox(height: kIsWeb ? 32 : 0),
    ]);

    return Stack(children: [
      MyIcons.boxBackground,
      Positioned.fill(child: child),
    ]);
  }



  Widget _buildTurntableView(BuildContext context) {
    final child = Column(mainAxisAlignment: MainAxisAlignment.end, children: [

      Stack(children: [
        Obx(() => MyTurntable(
          prizes: controller.state.turntablePrizes.value,
          key: controller.turntableKey,
          onSetReward: () async {
            await controller.state.result.update(controller.state.turntableIndex);
            if (controller.state.result.prize.no <= 0) {
              return null;
            }
            return controller.state.result.prize.no;
          },

          onResult: (index) async {
            controller.caidaiController.animationState.setAnimationByName(0, "animation", false);
            controller.state.isDisabled = false;
            await Future.delayed(const Duration(seconds: 1));
            _turntableSuccess(controller.state.turntablePrizes.value.list[index - 1].amount);
            await UserController.to.userInfo.value.update();
            UserController.to.userInfo.refresh();
          },
        )),

        Positioned.fill(
          bottom: 0,
          right: 0,
          child: SpineWidget.fromAsset(
            'assets/spine/eff_caidai_atlas.atlas',
            'assets/spine/eff_caidai_skel.skel',
            controller.caidaiController,
            fit: BoxFit.cover
          ),
        ),

        Positioned(
          bottom: 0,
          left: 0,
          child: SizedBox(
            height: 191 * 0.65,
            width: 178 * 0.65,
            child: SpineWidget.fromAsset(
              'assets/spine/zuo_atlas.atlas',
              'assets/spine/zuo_skel.skel',
              controller.leftBabyController,
              fit: BoxFit.cover
            ),
          ),
        ),

        Positioned(
          bottom: 0,
          right: 0,
          child: SizedBox(
            height: 172 * 0.65,
            width: 149 * 0.65,
            child: SpineWidget.fromAsset(
              'assets/spine/you_atlas.atlas',
              'assets/spine/you_skel.skel',
              controller.rightBabyController,
              fit: BoxFit.cover
            ),
          ),
        ),
      ]),


      SafeArea(top: false, child: Column(children: [
        MyButton(isDebounce: false, onPressed: () {
          controller.onStartSpine();
        }, child: _buildTurntableButton()),
        SizedBox(height: 20),
        Row(children: [
          SizedBox(width: 32),
          Expanded(child: Stack(children: [
            MyIcons.lotteryButton0,
            Positioned.fill(left: 10, right: 10, bottom: 10, child: Row(children: [
              Expanded(child: MyButton(isDebounce: false, onPressed: () async {
                controller.state.turntableIndex = 1;
                controller.state.isDisabled = true;
                await controller.state.turntablePrizes.value.update(1);
                controller.state.turntablePrizes.refresh();
              }, child: Stack(children: [
                Obx(() => controller.state.turntableIndex == 1
                  ? MyIcons.lotteryButton1
                  : MyIcons.lotteryButton2
                ),
                Positioned.fill(left: 8, right: 8, child: Center(child: FittedBox(child: MyStrokeText(
                  text: Lang.turntableSilver.tr,
                  fontSize: 18,
                  fontFamily: 'Sans',
                  strokeWidth: 4,
                  dy: 0,
                  maxLines: 1,
                )))),
              ]))),
              SizedBox(width: 4),
              Expanded(child: MyButton(isDebounce: false, onPressed: () async {
                controller.state.turntableIndex = 2;
                controller.state.isDisabled = true;
                await controller.state.turntablePrizes.value.update(2);
                controller.state.turntablePrizes.refresh();
              }, child: Stack(children: [
                Obx(() => controller.state.turntableIndex == 2
                  ? MyIcons.lotteryButton1
                  : MyIcons.lotteryButton2
                ),
                Positioned.fill(left: 8, right: 8, child: Center(child: FittedBox(child: MyStrokeText(
                  text: Lang.turntableGold.tr,
                  fontSize: 18,
                  fontFamily: 'Sans',
                  strokeWidth: 4,
                  dy: 0,
                  maxLines: 1,
                )))),
              ]))),
              SizedBox(width: 4),
              Expanded(child: MyButton(isDebounce: false, onPressed: () async {
                controller.state.turntableIndex = 3;
                controller.state.isDisabled = true;
                await controller.state.turntablePrizes.value.update(3);
                controller.state.turntablePrizes.refresh();
              }, child: Stack(children: [
                Obx(() => controller.state.turntableIndex == 3
                    ? MyIcons.lotteryButton1
                    : MyIcons.lotteryButton2
                ),
                Positioned.fill(left: 8, right: 8, child: Center(child: FittedBox(child: MyStrokeText(
                  text: Lang.turntableDiamond.tr,
                  fontSize: 18,
                  fontFamily: 'Sans',
                  strokeWidth: 4,
                  dy: 0,
                  maxLines: 1,
                )))),
              ])))
            ]))
          ])),
          SizedBox(width: 32),
        ],)
      ])),

      const SizedBox(height: kIsWeb ? 32 : 0),
    ]);

    return Stack(children: [
      MyIcons.lotteryBackground,
      Positioned.fill(child: child),
    ]);
  }

  Widget _buildTurntableButton() {
    return Row(children: [
      SizedBox(width: 90),
      SizedBox(height: 60, child: MyIcons.inviteWinIconLeft,),
      Expanded(child: Stack(children: [
        SizedBox(height: 60, child: MyIcons.inviteWinIconMiddle,),
        Positioned.fill(top: 4, child: Column(children: [
          Text(Lang.openTurntable.tr, style: TextStyle(
            fontSize: 16,
            fontFamily: 'Sans',
          )),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(height: 20, width: 20, child: MyIcons.headerStone),
            MyStrokeText(
              text: ' x 1',
              fontSize: 14,
              strokeWidth: 3,
              dy: 0,
              textColor: Color(0xFFFFFFFF),
            ),
          ]),
        ])),
      ])),
      SizedBox(height: 60, child: MyIcons.inviteWinIconRight,),
      SizedBox(width: 90),
    ]);
  }

  void _turntableSuccess(int data) {
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
        Positioned.fill(child: Center(child: SizedBox(width: 150, child: AnimatedChildWidget(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(width: 120, child: MyIcons.turntableWin),
          MyStrokeText(
            text: '$data',
            fontFamily: "Sans",
            fontSize: 20,
            strokeWidth: 4,
            dy: 4,
          ),
        ],)))))
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
}
