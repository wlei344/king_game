import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_game/common/common.dart';
import 'package:king_game/views/application/games/index.dart';
import 'package:king_game/views/application/mine/index.dart';
import 'package:king_game/views/application/store/index.dart';

import 'controller.dart';

class ApplicationView extends GetView<ApplicationController> {
  const ApplicationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: AlignmentDirectional.bottomCenter, children: [
        _buildBody(context),
        _buildFooter(context),
      ]),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Obx(() => IndexedStack(
      index: controller.state.pageIndex,
      children: [
        GamesView(),
        StoreView(),
        MineView(),
      ],
    ));
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 18),
            color: Color(0xFF002c58).withValues(alpha: 0.9),
            blurRadius: 10,
            spreadRadius: 8,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 2),


          Obx(() => Expanded(flex: controller.state.pageIndex == 0 ? 3 : 2, child: _buildNavigation(
            context: context,
            index: 0,
            height: MyConfig.app.bottomHeight,
            title: Lang.footerGames.tr,
            icon: MyIcons.footerGames,
          ))),

          const SizedBox(width: 2),

          Obx(() => Expanded(flex: controller.state.pageIndex == 1 ? 3 : 2, child: _buildNavigation(
            context: context,
            index: 1,
            height: MyConfig.app.bottomHeight,
            title: Lang.footerStore.tr,
            icon: MyIcons.footerStore,
          ))),

          const SizedBox(width: 2),

          Obx(() => Expanded(flex: controller.state.pageIndex == 2 ? 3 : 2, child: _buildNavigation(
            context: context,
            index: 2,
            height: MyConfig.app.bottomHeight,
            title: Lang.footerMine.tr,
            icon: MyIcons.footerMine,
          ))),

          const SizedBox(width: 2),
        ],
      ),
    );
  }

  Widget _buildNavigation({
    required BuildContext context,
    required int index,
    required double height,
    required String title,
    required Widget icon,
  }) {
    final radius = Radius.circular(20);
    final onPressed = controller.state.pageIndex == index ? null : () => controller.state.pageIndex = index;
    final boxColor = controller.state.pageIndex == index ? Color(0XFF00AAFF) : Color(0XFF00599C);
    final opacity = controller.state.pageIndex == index ? 1.0 : 0.0;
    final backgroundColor = controller.state.pageIndex == index ? Color.fromARGB(255, 97, 211, 250) : Color.fromARGB(255, 58, 133, 202);

    double bottom = MediaQuery.of(context).padding.bottom;

    // if (kIsWeb) {
    //   bottom = 10;
    // }

    final selectedText = MyStrokeText(
      text: title,
      fontFamily: 'Sans',
      fontSize: 18,
      strokeWidth: 4,
      strokeColor: Color(0xFF4D4D4D),
      shadowColor: Color(0xFF4D4D4D),
      dy: 4,
    );


    return LayoutBuilder(builder: (context, constraints) {
      final iconSize = constraints.maxWidth / 2.35;

      final defaultIcon = Column(children: [
        Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(height: iconSize, child: icon),
          SizedBox(height: 4),
          MyStrokeText(
            text: title,
            fontSize: 14,
            strokeWidth: 2,
            dy: 2,
          ),
        ])),
        Container(color: Colors.black.withValues(alpha: 0.1), height: bottom),
        // Text(title, style: TextStyle(fontSize: 14, color: Colors.white)),
      ]);

      final selectedIcon = SizedBox(height: iconSize, child: icon);

      final backgroundBox = Container(
        width: double.infinity,
        height: height + bottom,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft:  radius,
            topRight: radius,
          ),
        ),
        child: Stack(alignment: AlignmentDirectional.center, children: [
          Positioned.fill(top: 6, left: 2, right: 2, child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: boxColor,
              borderRadius: BorderRadius.only(
                topLeft:  radius,
                topRight: radius,
              ),
              boxShadow: [
                BoxShadow(
                  color: boxColor,
                  offset: Offset(0, 0),
                  blurRadius: 2,
                  spreadRadius: 4,
                ),
              ]
            ),
          )),
          Positioned(right: -2, top: (height + bottom) / 5, child: SizedBox(width: 10, child: MyIcons.footerRightIcon)),
          Positioned(left: -2, top: (height + bottom) / 2, child: SizedBox(width: 10, child: MyIcons.footerLeftIcon)),
          Positioned.fill(child: Opacity(opacity: opacity, child: MyIcons.footerSelected)),
          if (controller.state.pageIndex == index) Positioned(bottom: bottom + height * 0.1, child: selectedText),
          if (controller.state.pageIndex != index) defaultIcon,
          if (controller.state.pageIndex == index) Positioned(left: 0, right: 0, bottom: 0, child:
            Container(color: Colors.white.withValues(alpha: 0.2), height: bottom),
          ),
        ]),
      );
      return MyButton(
        onPressed: onPressed,
        isDebounce: false,
        child: Stack(clipBehavior: Clip.none, alignment: AlignmentDirectional.center, children: [
          backgroundBox,
          if (controller.state.pageIndex == index)
            Positioned(
              top: 0 - (height + bottom) / 7,
              child: selectedIcon,
            ),
        ]),
      );
    });
  }
}
