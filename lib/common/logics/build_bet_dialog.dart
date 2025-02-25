import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_game/common/common.dart';
import 'package:king_game/common/models/bet_model.dart';

Future<void> buildBetDialog({
  required String title,
  required BetType betType,
}) async {
  return showMyDialog(
    header: _buildHeader(
      title: title,
    ),
    body: _buildBody(
      betType: betType,
    ),
    footer: _buildFooter()
  );
}

Widget _buildHeader({
  required String title,
}) {
  return Stack(children: [
    Container(width: MyConfig.app.webBodyMaxWidth, height: MyConfig.app.alertHeaderHeight, color: Colors.red.withAlpha(0),),
    Positioned(top: -10, bottom: -20, left: 0, right: 0, child: FittedBox(child: MyIcons.gameTeam)),
    Positioned.fill(child: MyStrokeText(
      text: title,
      strokeWidth: 4,
      dy: 3,
      fontSize: 30,
      fontFamily: 'Sans',
    )),
  ]);
}

Widget _buildBody({
  required BetType betType,
}) {
  final betNumber = (-1).obs;
  final betIndex = (-1).obs;

  final child = Container(padding: EdgeInsets.fromLTRB(16, MyConfig.app.alertHeaderHeight / 2 + 16, 16, 16), child: SingleChildScrollView(
    child: Column(children: [
      buildOutlineBox(
        height: 120,
        color: Color(0xFF112A52).withValues(alpha: 0.7),
        borderColor: Color(0xFF3FB5EB),
        radius: 10,
        width: double.infinity,
        child: Column(children: [
          Row(children: [1, 2, 3, 4, 5].map((item) {
            return Expanded(child: Padding(padding: item == 5 ? EdgeInsets.zero : EdgeInsets.only(right: 4), child: Obx(() => buildCheckButton(
              isChecked: betNumber.value == item ? true : false,
              height: 40,
              onPressed: () {
                if (betNumber.value == item) {
                  betNumber.value = -1;
                } else {
                  betNumber.value = item;
                }
              },
              child: Center(
                child: MyStrokeText(
                  text:  Lang.betNumber.trArgs(['$item']),
                  fontSize: 14,
                  textColor: Color(0xFFFFFFFF),
                  strokeWidth: 3,
                ),
              ),
            ))));
          }).toList()),

          SizedBox(height: 8),

          Row(children: [6, 7, 8, 9, 10].map((item) {
            return Expanded(child: Padding(padding: item == 5 ? EdgeInsets.zero : EdgeInsets.only(right: 4), child: Obx(() => buildCheckButton(
              isChecked: betNumber.value == item ? true : false,
              height: 40,
              onPressed: () {
                if (betNumber.value == item) {
                  betNumber.value = -1;
                } else {
                  betNumber.value = item;
                }
              },
              child: Center(
                child: MyStrokeText(
                  text:  Lang.betNumber.trArgs(['$item']),
                  fontSize: 14,
                  textColor: Color(0xFFFFFFFF),
                  strokeWidth: 3,
                ),
              ),
            ))));
          }).toList()),
        ]),
      ),

      SizedBox(height: 16),// height: 90,

      buildOutlineBox(
        height: 70,
        color: Color(0xFF112A52).withValues(alpha: 0.7),
        borderColor: Color(0xFF3FB5EB),
        radius: 10,
        width: double.infinity,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(child: Obx(() => buildBetCheckButton(
            height: 40,
            isChecked: betIndex.value == 0 ? true : false,
            onPressed: () {
              if (betIndex.value == 0) {
                betIndex.value = -1;
              } else {
                betIndex.value = 0;
              }
            },
            child:Center(
              child: MyStrokeText(
                text:  betType == BetType.bigAndSmall ? Lang.betBig.tr : Lang.betOdd.tr,
                fontSize: 14,
                textColor: Color(0xFFFFFFFF),
                strokeWidth: 3,
              ),
            ),
          ))),
          SizedBox(width: 10),
          Expanded(child: Obx(() => buildBetCheckButton(
            height: 40,
            isChecked: betIndex.value == 1 ? true : false,
            onPressed: () {
              if (betIndex.value == 1) {
                betIndex.value = -1;
              } else {
                betIndex.value = 1;
              }
            },
            child:Center(
              child: MyStrokeText(
                text:  betType == BetType.bigAndSmall ? Lang.betSmall.tr : Lang.betEven.tr,
                fontSize: 14,
                textColor: Color(0xFFFFFFFF),
                strokeWidth: 3,
              ),
            ),
          ))),
        ]),
      ),

      SizedBox(height: 16),// height: 90,
      
      Container(
        height: 150,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF035173),
              Color(0xFF90D5EB),
            ],
          ),
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10)
        ),
      ),

      SizedBox(height: 50),// height: 90,
    ]),
  ));

  return Container(padding: EdgeInsets.fromLTRB(8, 0, 8, 8), child: Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: MyIcons.alertBodyBackground,
        repeat: ImageRepeat.repeat,
      ),
    ),
    child: child,
  ));
}

Widget _buildFooter() {
  return Container();
}