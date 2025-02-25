import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_game/common/common.dart';
import 'package:share_plus/share_plus.dart';

void buildInviteDialog() {
  final inviteData = InviteModel.empty().obs;
  final friendsIndex = 0.obs;
  inviteData.value.update().then((value) => inviteData.refresh());
  showMyDialog(
    header: Row(children: [
      SizedBox(height: MyConfig.app.alertHeaderHeight / 2, child: MyIcons.inviteHeaderIcon),
      SizedBox(width: 4,),
      MyStrokeText(
        text: Lang.inviteFriendsAlertTitle.tr,
        strokeWidth: 4,
        dy: 3,
        fontSize: 20,
        fontFamily: 'Sans',
      ),
    ],),
    body: Container(
      height: 570,
      decoration: BoxDecoration(
        // color: Color(0xFF213F98),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(children: [
        Obx(() => _buildTop(inviteData: inviteData.value)),
        Container(width: double.infinity, height: 2, color: Color(0xFF152966)),
        Container(width: double.infinity, height: 1, color: Color(0xFF596FB2)),
        Obx(() => _buildMiddle(inviteData: inviteData.value)),
        Expanded(child: Obx(() => _buildBottom(inviteData: inviteData.value, friendsIndex: friendsIndex))),
      ]),
    ),
  );
}

Widget _buildTop({
  required InviteModel inviteData,
}) {
  final inviteUserCount = Lang.inviteFriendsAlertFriends.trArgs(['${inviteData.inviteUserCount}']);
  final inviteUserCountList = inviteUserCount.split('${inviteData.inviteUserCount}');
  return Container(
    padding: EdgeInsets.fromLTRB(16, 50, 16, 16),
    decoration: BoxDecoration(
      color: Color(0xFF203C6F),
    ),
    child: Row(children: [
      Stack(children: [
        SizedBox(height: 60, child: MyIcons.inviteAlreadyBackground),
        Positioned.fill(left: 10, right: 10, child: Center(child: FittedBox(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(height: 30, child: MyIcons.inviteAlreadyCount),
          SizedBox(width: 8),
          MyStrokeText(
            text: inviteUserCountList.first,
            fontSize: 16,
            fontFamily: 'Sans',
            strokeWidth: 4,
            dy: 4,
            textColor: Color(0xFFFEDB00),
          ),
          MyStrokeText(
            text: '${inviteData.inviteUserCount}${inviteUserCountList.last}',
            fontSize: 16,
            fontFamily: 'Sans',
            strokeWidth: 4,
            dy: 4,
          ),
        ])))),
      ]),
      SizedBox(width: 10),
      Expanded(child: Row(children: [
        SizedBox(height: 60, child: MyIcons.inviteWinIconLeft,),
        Expanded(child: Stack(children: [
          SizedBox(height: 60, child: MyIcons.inviteWinIconMiddle,),
          Positioned.fill(top: 2, bottom: 22, child: MyIcons.headerCard),
          Positioned.fill(top: -14, child: Center(child: FittedBox(child: MyStrokeText(
            text: Lang.inviteFriendsAlertWin.tr,
            fontSize: 14,
            fontFamily: 'Sans',
            strokeWidth: 4,
            dy: 4,
          )))),
          Positioned.fill(top: 10, child: Center(child: FittedBox(child: MyStrokeText(
            text: 'x${inviteData.inviteTickets}',
            fontSize: 14,
            fontFamily: 'Sans',
            strokeWidth: 4,
            dy: 4,
            textColor: Color(0xFFFEDB00),
          )))),
        ],),),
        SizedBox(height: 60, child: MyIcons.inviteWinIconRight,)
      ])),
    ],),
  );
}

Widget _buildMiddle({
  required InviteModel inviteData,
}) {
  return Container(
    padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
    decoration: BoxDecoration(
      color: Color(0xFF213F98),
    ),
    child: Column(children: [
      Row(children: [
        Stack(children: [
          SizedBox(height: 40, child: MyIcons.inviteUrlBackgroundLeft),
          Positioned.fill(child: Center(child: SizedBox(height: 18, child: MyIcons.inviteUrl)))
        ]),
        Expanded(child: Stack(children: [
          SizedBox(height: 40, child: MyIcons.inviteUrlBackgroundMiddle),
          Positioned(left: 10, top: 0, right: 10, bottom: 0, child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(Lang.inviteFriendsAlertUrl.tr, style: TextStyle(fontSize: 13, color: Color(0xFF95C1F1))),
            FittedBox(child: Text(inviteData.inviteUrl, style: TextStyle(fontSize: 13, color: Color(0xFFFFFFFF))))
          ]))
        ])),
        SizedBox(height: 40, child: MyIcons.inviteUrlBackgroundRight),
        SizedBox(width: 10),
        SizedBox(height: 40, child: MyButton(onPressed: () {
          inviteData.inviteUrl.copyToClipBoard();
          MyAlert.showSnack(child: Text(Lang.copySuccessful.tr, style: TextStyle(color: Colors.white)));
        }, child: MyIcons.inviteUrlCopy)),
        SizedBox(width: 10),
        MyButton(onPressed: () {
          Share.share(inviteData.inviteUrl);
        }, child: SizedBox(height: 40, child: MyIcons.inviteUrlShare),)
      ]),
      SizedBox(height: 10),
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFF152966),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(width: double.infinity),
          Text(Lang.inviteFriendsAlertInfoTitle.tr, style: TextStyle(fontSize: 15, color: Color(0xFFFFFFFF))),
          SizedBox(height: 10),
          Text(Lang.inviteFriendsAlertInfoMessage.tr, style: TextStyle(fontSize: 13, color: Color(0xFF86D7F7))),
        ]),
      ),
      SizedBox(height: 10),

    ]),
  );
}

Widget _buildBottom({
  required InviteModel inviteData,
  required RxInt friendsIndex,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Color(0xFF64AAF1),
      borderRadius: BorderRadius.only(bottomRight: Radius.circular(8), bottomLeft: Radius.circular(8))
    ),
    child: Column(children: [
      Stack(clipBehavior: Clip.none, children: [
        SizedBox(height: 40, width: double.infinity),
        Positioned(top: -20, left: 20, right: 20, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Obx(() => MyButton(onPressed: friendsIndex.value == 0 ? null : () {
            friendsIndex.value = 0;
            friendsIndex.refresh();
          }, child: Stack(children: [
            SizedBox(height: 40, child: Obx(() => friendsIndex.value == 0 ? MyIcons.inviteButton1 : MyIcons.inviteButton0)),
            Positioned.fill(left: 10, right: 10, child: Center(child: FittedBox(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(height: 16, child: MyIcons.inviteRegister),
              SizedBox(width: 4),
              Text(Lang.inviteFriendsAlertTypeRegister.tr, style: TextStyle(fontSize: 13, color: Color(0xFFFFFFFF))),
            ])))),
          ]))),
          SizedBox(width: 10),
          Obx(() => MyButton(onPressed: friendsIndex.value == 1 ? null : () {
            friendsIndex.value = 1;
            friendsIndex.refresh();
          }, child: Stack(children: [
            SizedBox(height: 40, child: Obx(() => friendsIndex.value == 1 ? MyIcons.inviteButton1 : MyIcons.inviteButton0)),
            Positioned.fill(left: 10, right: 10, child: Center(child: FittedBox(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(height: 16, child: MyIcons.inviteRecharged),
              SizedBox(width: 4),
              Text(Lang.inviteFriendsAlertRecharge.tr, style: TextStyle(fontSize: 13, color: Color(0xFFFFFFFF))),
            ])))),
          ])))
        ]))
      ],),
      Expanded(child: Container())
    ],),
  );
}
