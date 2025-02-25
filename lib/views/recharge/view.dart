import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_game/common/common.dart';
import 'package:url_launcher/url_launcher.dart';

import 'controller.dart';

class RechargeView extends GetView<RechargeController> {
  const RechargeView({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
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
            SizedBox(height: 30, child: MyIcons.storeTitleIcon),
            SizedBox(width: 8),
            MyStrokeText(
              text: Lang.rechargeViewTitle.tr,
              fontSize: 18,
              strokeWidth: 4,
              dy: 3,
              fontFamily: 'Sans',
            )
          ]))),
          Expanded(child: _buildContent(context)),
        ]),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(padding: EdgeInsets.all(10), child: Column(children: [
      SizedBox(height: 8),

      Stack(clipBehavior: Clip.none, children: [
        MyIcons.storeBannerBackground,
        Positioned(left: 24, child: Column(children: [
          SizedBox(height: 60, child: MyIcons.storeBanner1),
          MyStrokeText(
            text: Lang.rechargeViewBuy.tr,
            fontSize: 18,
            fontFamily: 'Sans',
            strokeWidth: 4,
            dy: 3,
          )
        ])),
      ]),

      Expanded(child: GridView.count(
        padding: EdgeInsets.only(top: 16, left: 4, right: 4),
        crossAxisCount: 3,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 223 / 330,
        children: controller.state.amounts.asMap().entries.map((item) {
          final child = Stack(children: [
            MyIcons.storeBuy(item.value),
            Positioned(bottom: 10, right: 10, left: 10, child: Center(child: FittedBox(child: MyStrokeText(
              text: '${Lang.rechargeViewMoney.tr}  ${item.value * UserController.to.userInfo.value.vndRate ~/ 1000}K',
              fontSize: 18,
              fontFamily: 'Sans',
              strokeWidth: 4,
              dy: 3,
            ))))
          ]);

          return MyButton(onPressed: () async {
            showMyLoading();
            await UserController.to.myDio?.post(MyApi.user.payOrder,
              data: {
                "bizAmt": item.value * UserController.to.userInfo.value.vndRate,
              },
              onSuccess: (code, msg, data) async {
                final url =  Uri.parse('$data');
                if (!await launchUrl(url)) {
                  MyAlert.showSnack(child: Text('Could not launch $url', style: TextStyle(color: Colors.white)));
                }
              },
            );
            hideMyLoading();
          }, child: child);
        }).toList()
      )),
    ]));
  }
}
