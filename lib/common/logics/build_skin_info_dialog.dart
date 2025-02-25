import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_game/common/common.dart';

Widget buildSkinItem({
  required SkinModel skinData,
  void Function()? onPressed,
}) {
  int level = 1;

  if (skinData.type == 's+') {
    level = 2;
  } else if (skinData.type == 'S++') {
    level = 3;
  }

  final skinLevel = SizedBox(width: 40, child: MyIcons.storeSkinLevel(level));

  final image = MyIcons.storeSkin(skinData.url);
  final name = MyStrokeText(
    text: skinData.name,
    strokeWidth: 3,
    dy: 0,
    dx: 0,
    fontSize: 13,
  );
  final price = MyStrokeText(
    text: '${skinData.price}${Lang.points.tr}',
    fontFamily: 'Sans',
    fontSize: 14,
  );

  final body = Stack(children: [
    image,

    Positioned(
      top: 4,
      left: 8,
      right: 8,
      child: Align(
        alignment: Alignment.centerLeft,
        child: FittedBox(child: name),
      ),
    ),

    Positioned(
      bottom: 14,
      right: 10,
      left: 46,
      child: Align(
        alignment: Alignment.centerRight,
        child: FittedBox(child: price),
      ),
    ),

    Positioned(
      bottom: 8,
      left: 4,
      child: skinLevel,
    ),
  ]);

  return MyButton(onPressed: onPressed, child: body);
}

Future<void> buildSkinInfoDialog(SkinModel skinData) async {
  return showMyDialog(
    header: _buildHeader(),
    body: _buildBody(skinData),
    footer: _buildFooter(skinData),
  );
}

Widget _buildFooter(SkinModel skinData) {
  return buildButton(
    onPressed: () async {
      Get.back();
      showMyLoading();
      await UserController.to.myDio?.post(MyApi.user.redeemSkin,
        data: {"skinId": skinData.id},
        onSuccess: (code, msg, data) {
          _exchangeSuccess(skinData);
        },
        onError: (e) {
          MyAlert.showSnack(child: Text('${e.error}', style: TextStyle(color: Colors.white)));
          _exchangeFailed();
        }
      );
      hideMyLoading();
      UserController.to.userInfo.value.update().then((value) {
        UserController.to.userInfo.refresh();
      });
    },
    margin: const EdgeInsets.symmetric(vertical: 18, horizontal: 80),
    height: 44,
    colors: [Color(0xFFF96312), Color(0xFFF96312)],
    shadowColor: Color(0xFF944600),
    child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(height: 30, child: MyIcons.headerCard),
      Flexible(child: FittedBox(child: MyStrokeText(
        text: Lang.exchangeSureDo.tr,
        strokeWidth: 4,
        dy: 3,
        fontFamily: 'Sans',
        fontSize: 13,
      ))),
      SizedBox(width: 8),
    ])),
  );
}

Widget _buildHeader() {
  return MyStrokeText(
    text: Lang.skinDialogTitle.tr,
    strokeWidth: 4,
    dy: 3,
    fontSize: 20,
    fontFamily: 'Sans',
  );
}

Widget _buildBody(SkinModel skinData) {
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
        SizedBox(width: 150, child: buildSkinItem(skinData: skinData)),

        SizedBox(height: 10),

        buildOutlineBox(
          color: Color(0xFF112A52).withValues(alpha: 0.7),
          borderColor: Color(0xFF3FB5EB),
          radius: 10,
          width: double.infinity,
          child: Column(children: [
            Stack(clipBehavior: Clip.none, children: [
              SizedBox(
                height: 20,
                width: double.infinity,
              ),
              Positioned(top: -4, child: MyStrokeText(
                text: skinData.name,
                strokeWidth: 3,
                dy: 0,
                dx: 0,
                fontSize: 18,
              )),
            ]),

            SizedBox(height: 10),

            Text(skinData.remark, style: TextStyle(color: Colors.white)),

            SizedBox(height: 16),
          ])
        ),

        SizedBox(height: 16 + 32),

      ]),
    )),
  );
}

void _exchangeSuccess(SkinModel skinData) {
  MyAudio.play(MyAudioPath.exchangeSuccessful);
  buildPrizeDialog(child: Column(mainAxisSize: MainAxisSize.min, children: [
    MyStrokeText(
      text: Lang.exchangeSuccess.tr,
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

void _exchangeFailed() {
  MyAudio.play(MyAudioPath.exchangeFailed);
  buildPrizeDialog(child: Column(mainAxisSize: MainAxisSize.min, children: [
    Stack(children: [
      SizedBox(width: 250, child: MyIcons.alertFailed),
      Positioned(bottom: 16, left: 50, right: 50, child: SizedBox(
        height: 30,
        child: Center(child: FittedBox(child: MyStrokeText(
          text: Lang.exchangeFailure.tr,
          strokeWidth: 4,
          dy: 3,
          fontSize: 20,
          fontFamily: 'Sans',
        ))),
      )),
    ]),

    MyButton(onPressed: () => Get.back(), child: Container(height: 50, width: double.infinity, color: Colors.white.withAlpha(0))),
    Container(height: 40, width: double.infinity, color: Colors.white.withAlpha(0), child: MyButton(onPressed: () => Get.back(), child: MyIcons.close)),

  ]));
}
