import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_game/common/common.dart';
import 'package:king_game/common/models/bet_model.dart';

import 'controller.dart';

class BetView extends GetView<BetController> {
  const BetView({super.key});

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
          _buildHeader(context),
          Expanded(child: _buildContent(context)),
        ]),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return buildHeader(context, bottom: buildBack(
      child: Row(children: [
        SizedBox(width: 20),
        SizedBox(height: 30, child: MyIcons.gameTitle(2)),
        SizedBox(width: 8),
        Obx(() => MyStrokeText(
          text: controller.state.gameIndex == 0 ? Lang.gameViewBigOrSmallBetting.tr : Lang.gameViewOddOrEvenBetting.tr,
          fontSize: 18,
          strokeWidth: 4,
          dy: 4,
          fontFamily: 'Sans',
        )),
        Spacer(),
        SizedBox(
          width: 24,
          height: 24,
          child: MyIcons.gameHelp,
        ),
        SizedBox(width: 10),
      ]),
    ));
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      color: Color(0xFFF9E7C9),
      child: SafeArea(top: false, child: Stack(children: [
        Positioned(top: 40, left: 0, right: 0, bottom: 0, child: _buildGameBody(context)),
        Positioned(top: 0, left: 0, right: 0, child: _buildTitle(context)),
      ])),
    );
  }
  
  Widget _buildTitle(BuildContext context) {
    return SizedBox(
      height: 42,
      child: Row(children: [
        Expanded(child: _buildTitleButton(
          context: context,
          index: 0,
          title: Lang.gameViewBigOrSmallBetting.tr,
        )),
        SizedBox(width: 2),
        Expanded(child: _buildTitleButton(
          context: context,
          index: 1,
          title: Lang.gameViewOddOrEvenBetting.tr,
        )),
        SizedBox(width: 16),
      ]),
    );
  }

  Widget _buildTitleButton({
    required BuildContext context,
    required index,
    required String title,
  }) {
    return Align(
      alignment: Alignment.topCenter,
      child: Obx(() {
        final titleBox = MyStrokeText(
          text: title,
          fontSize: 18,
          fontFamily: 'Sans',
          strokeWidth: 3,
          dy: 3,
        );

        final bodyDefault = Stack(children: [
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Color(0xFF36364A),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              )
            ),
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: Container(
            height: 10,
            decoration: BoxDecoration(
              //渐变色
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black,
                  Colors.black.withAlpha(0),
                ],
              ),
            ),
          )),
          Positioned.fill(left: 8, right: 8, top: 8, bottom: 8, child: Center(child: FittedBox(child: titleBox)))
        ]);

        final bodyCheck = Container(
          height: 42,
          decoration: BoxDecoration(
            color: Color(0xFFF0CB9A),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            border: Border(
              top: BorderSide(
                color: Color(0XFFE1BD86),
                width: 2,
              ),
              left: BorderSide(
                color: Color(0XFFE1BD86),
                width: 2,
              ),
              right: BorderSide(
                color: Color(0XFFE1BD86),
                width: 2,
              ),
            ),
          ),
          child: Center(child: FittedBox(child: titleBox)),
        );

        return MyButton(isDebounce: false, onPressed: controller.state.gameIndex == index ? null : () {
          controller.state.gameIndex = index;
        }, child: Container(
          width: double.infinity,
          color: Colors.green.withAlpha(0),
          height: controller.state.gameIndex == index ? 42 : 40,
          child: Column(children: [
            controller.state.gameIndex == index ? bodyCheck : bodyDefault,
          ]),
        ));
      }),
    );
  }
  
  Widget _buildGameBody(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0XFFF0CB9A),
        border: Border.all(
          color: Color(0XFFE1BD86),
          width: 2
        ),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(16),
          bottomLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        )
      ),
      child: Column(children: [
        Expanded(child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(children: List.generate(20, (index) => MyButton(
            isDebounce: false,
            onPressed: () {
              buildBetDialog(
                sessionIndex: controller.state.sessionIndex,
                competitionType: '联赛',
                title: controller.state.gameIndex == 0 ? Lang.gameViewBigOrSmallBetting.tr : Lang.gameViewOddOrEvenBetting.tr,
                betType: controller.state.gameIndex == 0 ? BetType.bigAndSmall : BetType.oddAndEven,
              );
            },
            child: _buildGameBox(
              context: context,
              index: index,
              teamNameLeft: '北京国安',
              teamNameRight: '上海申花',
              teamIconLeft: 'icon_bj_gn',
              teamIconRight: 'icon_sh_sf',
              competitionType: '联赛',
              competitionName: '2023 全国��',
              competitionSessions: '30',
              competitionTime: '2023-06-15 18:00:00',
              betType: BetType.bigAndSmall,
            ),
          ))),
        )),

        Container(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          height: 60,
          child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: List.generate(20, (index) => _buildSessionButtons(
            context: context,
            index: index,
            title: '第${index + 1}场',
          )))),
        ),
      ]),
    );
  }

  Widget _buildSessionButtons({
    required BuildContext context,
    required int index,
    required String title,
  }) {
    final titleBox = Text(title,
      style: TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontWeight: controller.state.sessionIndex == index? FontWeight.bold : FontWeight.normal,
      ),
    );

    return Obx(() => MyButton(isDebounce: false, onPressed: () {
      controller.state.sessionIndex = index;
    }, child: Container(
      padding: EdgeInsets.fromLTRB(16, 6, 16, 6),
      margin: EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFF000000),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
        color: controller.state.sessionIndex == index ? Color(0xFF5380EF) : Color(0xFF36364A),
      ),
      child: titleBox,
    )));
  }

  Widget _buildGameBox({
    required BuildContext context,
    required int index,
    required String teamNameLeft,
    required String teamNameRight,
    required String teamIconLeft,
    required String teamIconRight,
    required String competitionType,
    required String competitionName,
    required String competitionSessions,
    required String competitionTime,
    required BetType betType,
  }) {
    final body = Obx(() => Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFFAF8B6B),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(16),
        gradient:  LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            controller.state.gameIndex == 0 ? Color(0xFFA82800) : Color(0xFF026C00),
            controller.state.gameIndex == 0 ? Color(0xFFEBBB90) : Color(0xFF90EBB9),
          ],
        ),
      ),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(children: [
            Container(
              width: 40,
              height: 40,
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Color(0xFF2A042E),
                shape: BoxShape.circle,
              ),
              child: MyIcons.gameLeft,
            ),
            SizedBox(width: 4),
            MyStrokeText(
              text: teamNameLeft,
              fontSize: 16,
              fontFamily: 'Sans',
              dy: 3,
            ),
          ]),
          Row(children: [
            MyStrokeText(
              text: teamNameRight,
              fontSize: 16,
              fontFamily: 'Sans',
              dy: 3,
            ),
            SizedBox(width: 4),
            Container(
              width: 40,
              height: 40,
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Color(0xFF2A042E),
                shape: BoxShape.circle,
              ),
              child: MyIcons.gameRight,
            ),
          ]),
        ]),

        const SizedBox(height: 10),

        Container(height: 1, color: Colors.black.withValues(alpha: 0.3)),
        Container(height: 2, color: Colors.white.withValues(alpha: 0.2)),

        const SizedBox(height: 10),

        Row(children: [
          Expanded(child: Container(
            padding: EdgeInsets.all(8),
            height: 70,
            decoration: BoxDecoration(
              color: controller.state.gameIndex == 0 ? Color(0xFF96431E) : Color(0xFF1A8022),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: Color(0xFF41180B),
                  width: 1
              ),
            ),
            child: Column(children: [
              Row(children: [
                Container(
                  padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
                  decoration: BoxDecoration(
                    color: controller.state.gameIndex == 0 ? Color(0xFFFFB21B) : Color(0xFFFFF61B),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: MyStrokeText(
                    text: competitionType,
                    fontSize: 14,
                    fontFamily: 'Sans',
                    strokeWidth: 2,
                    dy: 0,
                  ),
                ),

                const SizedBox(width: 8),

                Flexible(child: FittedBox(child: MyStrokeText(
                  text: competitionName,
                  fontSize: 14,
                  dy: 0,
                  strokeWidth: 1,
                  // fontFamily: 'Sans',
                  textColor: controller.state.gameIndex == 0 ? Color(0xFFFFB21B) : Color(0xFFFFF61B),
                ))),
              ]),
              const SizedBox(height: 4),
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                MyStrokeText(
                  text: competitionSessions,
                  fontSize: 14,
                  textColor: Color(0xFFFFFFFF),
                  strokeWidth: 2,
                  dy: 0,
                ),

                const SizedBox(width: 8),

                Flexible(child: FittedBox(child: MyStrokeText(
                  text: competitionTime,
                  fontSize: 14,
                  strokeWidth: 1,
                  dy: 0,
                  textColor: controller.state.gameIndex == 0 ?  Color(0xFFCBA18E) : Color(0xFF8CBF90),
                )))
              ])
            ]),
          )),

          const SizedBox(width: 10),

          SizedBox(
            width: 70,
            height: 70,
            child: Row(children: [
              SizedBox(height: 70, child: MyIcons.inviteWinIconLeft,),
              Expanded(child: Stack(children: [
                SizedBox(height: 70, child: MyIcons.inviteWinIconMiddle,),
                Positioned.fill(bottom: 9, child: Center(child: FittedBox(child: MyStrokeText(
                  text: '竞猜',
                  fontSize: 18,
                  fontFamily: 'Sans',
                  dy: 3,
                )))),
              ])),
              SizedBox(height: 70, child: MyIcons.inviteWinIconRight,)
            ]),
          )
        ])
      ]),
    ));

    return Stack(alignment: AlignmentDirectional.topCenter, clipBehavior: Clip.none, children: [
      body,
      Positioned(top: -10, child: SizedBox(
        width: 66,
        child: MyIcons.gameTeam,
      ))
    ]);
  }
}
