import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_game/common/common.dart';

Widget buildHeader(BuildContext context, {
  double headerHeight = 55.0,
  bool isShowMarker = false,
  Widget? bottom,
}) {
  final double padding = 10.0;

  final leftChildBackground = Row(
    children: [
      Expanded(child: MyIcons.headerBackground1),
      SizedBox(child: MyIcons.headerBackground2),
    ],
  );

  final leftUserInfo = MyButton(
    isDebounce: false,
    onPressed: () => buildUserInfoDialog(),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          width: headerHeight,
          height: headerHeight,
          child: Stack(children: [
            MyIcons.headerAvatarBackground,
            Positioned.fill(child: Padding(padding: EdgeInsets.fromLTRB(2, 2, 2, 4), child: MyIcons.headerAvatar)),
          ]),
        ),

        const SizedBox(width: 6),

        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.end, children: [
          Obx(() => MyStrokeText(
            text: UserController.to.userInfo.value.nickname,
            fontFamily: 'Sans',
            overflow: TextOverflow.clip,
            maxLines: 1,
            fontSize: 14,
            strokeWidth: 3,
            dy: 4,
          )),
          Obx(() => Text('ID: ${UserController.to.userInfo.value.id}',
            maxLines: 1,
            style: TextStyle(color: Color(0xFFF8D21C), fontSize: 14),
            overflow: TextOverflow.clip,
          )),
          // const SizedBox(height: 3),
        ])),

        const SizedBox(width: 48),
      ],
    ),
  );

  Widget buildButton({
    void Function()? onPressed,
    required Widget icon,
    required Widget addButton,
    required String balance,
  }) {
    final buttonHeight = headerHeight / 2;

    final background = Container(
      height: buttonHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colors.black,
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Column(children: [
        Container(
          height: buttonHeight / 2,
          decoration: BoxDecoration(
            color: Color(0xFF444444),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
            ),
          ),
        ),
      ]),
    );

    final iconHeight = buttonHeight * 1.25;

    return MyButton(
      onPressed: onPressed,
      child: Stack( children: [
        Container(
          height: iconHeight,
          width: double.infinity,
          padding: EdgeInsets.only(left: 12),
          child: Center(child: background),
        ),
        Positioned.fill(
          child: Row(children: [
            SizedBox(width: iconHeight, height: iconHeight, child: icon),
            SizedBox(width: 4),
            Expanded(child: Center(child: FittedBox(child: Text(balance, style: TextStyle(color: Colors.white, fontSize: 14))))),
            SizedBox(
              width: buttonHeight,
              height: iconHeight,
              child: Padding(padding: EdgeInsets.all(4), child: addButton),
            )
          ]),
        ),
      ]),
    );
  }

  final rightButtons = Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      // SizedBox(width: padding),
      Expanded(child: Obx(() => buildButton(
        onPressed: () => Get.toNamed(MyRoutes.recharge),
        icon: MyIcons.headerStone,
        addButton: MyIcons.headerAdd2,
        balance: '${UserController.to.userInfo.value.balance}'
      ))),
      SizedBox(width: 4),
      Expanded(child: Obx(() => buildButton(
        onPressed: () => buildExchangeDialog(),
        icon: MyIcons.headerCard,
        addButton: MyIcons.headerAdd1,
        balance: '${UserController.to.userInfo.value.tickets}'
      ))),
      SizedBox(width: padding),
    ],
  );

  final body = Stack(
    alignment: AlignmentDirectional.bottomStart,
    clipBehavior: Clip.none,
    children: [
      if (isShowMarker)
        Container(
          width: double.infinity,
          height: headerHeight,
          color: Colors.black.withValues(alpha: 0.5),
        ),

      Row(
        children: [
          Expanded(child: SizedBox(height: headerHeight, child: leftChildBackground)),
          Expanded(child: SizedBox(height: headerHeight, child: rightButtons)),
        ],
      ),

      Positioned.fill(
        bottom: padding,
        left: padding,
        child: Row(children: [
          Expanded(child: leftUserInfo),
          Expanded(child: SizedBox())
        ]),
      ),
    ],
  );

  // return SizedBox(
  //   height: headerHeight + padding,
  //   child: body,
  // );

  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        alignment: Alignment.topCenter,
        image: MyIcons.headerBackground,
        fit: BoxFit.cover,
      ),
    ),
    child: SafeArea(bottom: false, left: false, right: false, child: Column(
      children: [
        if (kIsWeb) SizedBox(height: 20),
        SizedBox(
          height: headerHeight + padding,
          child: body,
        ),
        if (bottom!= null)
          SizedBox(height: 10),
        if (bottom!= null)
          bottom,
      ],
    )),
  );
}