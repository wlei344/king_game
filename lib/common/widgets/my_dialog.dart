import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_game/common/common.dart';

void showMyLoading() => MyAlert.showLoading();
void hideMyLoading() => MyAlert.hideLoading();
void showMyBlock() => MyAlert.showBlock();
void hideMyBlock() => MyAlert.hideBlock();
void showMySnack({Widget? child}) => MyAlert.showSnack(child: child);

Future<void> showMyDialog({
  required Widget header,
  required Widget body,
  Widget? footer,
}) async {
  final child = Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: Color(0xFF606C83),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: Color(0xFF81868F),
        width: 2,
      ),
    ),
    child: Stack(clipBehavior: Clip.none, children: [
      body,

      Positioned(left: -24, top: -20, right: -24, child: Row(children: [
        SizedBox(height: MyConfig.app.alertHeaderHeight, child: MyIcons.alertHeaderLeft),
        SizedBox(height: MyConfig.app.alertHeaderHeight, child: MyIcons.alertHeaderTopLeft),
        Expanded(child: SizedBox(height: MyConfig.app.alertHeaderHeight, child: MyIcons.alertHeaderCenter)),
        SizedBox(height: MyConfig.app.alertHeaderHeight, child: MyIcons.alertHeaderTopRight),
        SizedBox(height: MyConfig.app.alertHeaderHeight, child: MyIcons.alertHeaderRight),
      ])),

      Positioned(left: 24, top: -20, right: 24, child: Align(alignment: Alignment.topCenter, child: SizedBox(
        height: MyConfig.app.alertHeaderHeight / 1.8,
        child: Center(child: FittedBox(child: header)),
      ))),

      if (footer != null)
        Positioned(left: -6, bottom: -20, right: -6, child: Row(children: [
          SizedBox(height: MyConfig.app.alertFooterHeight, child: MyIcons.alertBottomLeft1),
          SizedBox(height: MyConfig.app.alertFooterHeight, child: MyIcons.alertBottomLeft2),
          Expanded(child: SizedBox(height: MyConfig.app.alertFooterHeight, child: MyIcons.alertBottomCenter)),
          SizedBox(height: MyConfig.app.alertFooterHeight, child: MyIcons.alertBottomRight2),
          SizedBox(height: MyConfig.app.alertFooterHeight, child: MyIcons.alertBottomRight1),
        ])),

      if (footer != null)
        Positioned(left: -6, bottom: -25, right: -6, child: Align(alignment: Alignment.topCenter, child: SizedBox(
          height: MyConfig.app.alertFooterHeight,
          child: footer,
        ))),
    ]),
  );

  return Get.generalDialog<dynamic>(
    barrierLabel: '',
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: GestureDetector(
              onTap: () {
                // MyAudio.play(MyAudioPath.click);
                Get.back();
              },
              child: Container(
                color: Colors.black.withValues(alpha: 0.5),
              ),
            ),
          ),
          Center(
            child: SafeArea(child: Padding(padding: EdgeInsets.all(20), child: Material(
              color: Colors.transparent,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: Get.height * 0.8,
                ),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Flexible(child: child),
                  GestureDetector(
                    onTap: () {
                      // MyAudio.play(MyAudioPath.click);
                      Get.back();
                    },
                    child: Column(children: [
                      Container(height: 50, width: double.infinity, color: Colors.white.withAlpha(0)),
                      Container(height: 40, width: double.infinity, color: Colors.white.withAlpha(0), child: MyButton(onPressed: () => Get.back(), child: MyIcons.close)),
                    ]),
                  ),
                ]),
              ),
            ))),
          ),
        ],
      );
    },
  );
}
