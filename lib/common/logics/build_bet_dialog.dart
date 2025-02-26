import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_game/common/common.dart';
import 'package:king_game/common/models/bet_model.dart';

Future<void> buildBetDialog({
  required String title,
  required BetType betType,
  required String competitionType,
  required int sessionIndex,
}) async {
  int amount = 0;
  final clearNumber = 0.obs;
  return showMyDialog(
    header: _buildHeader(
      title: title,
    ),
    body: Obx(() => BetBody(
      onChange: (value) {
        amount = value;
      },
      betType: betType,
      competitionType: competitionType,
      sessionIndex: sessionIndex,
      clearNumber: clearNumber.value,
    )),
    footer: _buildFooter(
      amount: amount,
      clearNumber: clearNumber,
    )
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

Widget _buildFooter({
  required int amount,
  required RxInt clearNumber,
}) {
  return Container(
    padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
    child: Row(children: [
      Expanded(child: MyButton(isDebounce: false, onPressed: () {
        clearNumber.value++;
        clearNumber.refresh();
        print(clearNumber.value);
      }, child: Container(
        height: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color:  Color(0xFF5380EF),
          border: Border.all(color: Colors.black,  width: 1),
        ),
        child: Center(child: FittedBox(child: MyStrokeText(
          text: Lang.betClear.tr,
          strokeWidth: 3,
          dy: 3,
          fontFamily: 'Sans',
          fontSize: 14,
        ))),
      ))),
      SizedBox(width: 10),
      Expanded(child: buildButton(
        onPressed: () {
          Get.back();
        },
        height: 44,
        colors: [Color(0xFFF96312), Color(0xFFF96312)],
        shadowColor: Color(0xFF944600),
        child: Center(child: FittedBox(child: MyStrokeText(
          text: Lang.betConfirm.tr,
          strokeWidth: 3,
          dy: 3,
          fontFamily: 'Sans',
          fontSize: 14,
        ))),
      )),
    ],),
  );
}

class BetBody extends StatefulWidget {
  final BetType betType;
  final String competitionType;
  final int sessionIndex;
  final void Function(int amount) onChange;
  final int clearNumber;

  const BetBody({
    required this.betType,
    required this.competitionType,
    required this.sessionIndex,
    required this.onChange,
    required this.clearNumber,
    super.key,
  });

  @override
  State<BetBody> createState() => _BetBodyState();
}

class _BetBodyState extends State<BetBody> {
  int betNumber = -1;
  int betIndex = -1;
  final amountController = TextEditingController();

  @override
  void didUpdateWidget(covariant BetBody oldWidget) {
    if (widget.clearNumber > 0) {
      amountController.clear();
      setState(() {
        betNumber = -1;
        betIndex = -1;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: MyIcons.alertBodyBackground,
            repeat: ImageRepeat.repeat,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
              16, MyConfig.app.alertHeaderHeight / 2 + 16, 16, 16),
          child: Column(
            children: [
              buildOutlineBox(
                height: 120,
                color: const Color(0xFF112A52).withAlpha((0.7 * 255).toInt()),
                borderColor: const Color(0xFF3FB5EB),
                radius: 10,
                width: double.infinity,
                child: Column(
                  children: [
                    _buildBetRow([1, 2, 3, 4, 5]),
                    const SizedBox(height: 8),
                    _buildBetRow([6, 7, 8, 9, 10]),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              buildOutlineBox(
                height: 70,
                color: const Color(0xFF112A52).withAlpha((0.7 * 255).toInt()),
                borderColor: const Color(0xFF3FB5EB),
                radius: 10,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: _buildBetCheckButton(0, widget.betType == BetType.bigAndSmall ? Lang.betBig.tr : Lang.betOdd.tr),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildBetCheckButton(1, widget.betType == BetType.bigAndSmall ? Lang.betSmall.tr : Lang.betEven.tr),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _buildInfoContainer(),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBetRow(List<int> numbers) {
    return Row(
      children: numbers.map((item) {
        return Expanded(
          child: Padding(
            padding: item == numbers.last ? EdgeInsets.zero : const EdgeInsets.only(right: 4),
            child: buildCheckButton(
              isChecked: betNumber == item,
              height: 40,
              onPressed: () {
                setState(() {
                  betNumber = betNumber == item ? -1 : item;
                });
              },
              child: Center(
                child: MyStrokeText(
                  text: Lang.betNumber.trArgs(['$item']),
                  fontSize: 14,
                  textColor: const Color(0xFFFFFFFF),
                  strokeWidth: 3,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBetCheckButton(int index, String text) {
    return buildBetCheckButton(
      height: 40,
      isChecked: betIndex == index,
      onPressed: () {
        setState(() {
          betIndex = betIndex == index ? -1 : index;
        });
      },
      child: Center(
        child: MyStrokeText(
          text: text,
          fontSize: 14,
          textColor: const Color(0xFFFFFFFF),
          strokeWidth: 3,
        ),
      ),
    );
  }

  Widget _buildInfoContainer() {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 190,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF035173), Color(0xFF90D5EB)],
        ),
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: MyIcons.gameLeft,
              ),
              const SizedBox(width: 4),
              MyStrokeText(
                text: '第${widget.sessionIndex + 1}场 ',
                fontSize: 15,
                textColor: const Color(0xFFFFFFFF),
                strokeWidth: 2,
                dy: 2,
                fontFamily: 'Sans',
              ),
              MyStrokeText(
                text: '${widget.competitionType} ',
                fontSize: 15,
                textColor: const Color(0xFFFFFFFF),
                strokeWidth: 2,
                dy: 2,
                fontFamily: 'Sans',
              ),
              if (betIndex >= 0)
                MyStrokeText(
                  text: betIndex == 0 ? (widget.betType == BetType.bigAndSmall ? Lang.betBig.tr : Lang.betOdd.tr) : (widget.betType == BetType.bigAndSmall ? Lang.betSmall.tr : Lang.betEven.tr),
                  fontSize: 15,
                  textColor: const Color(0xFFFCC151),
                  strokeWidth: 2,
                  dy: 2,
                  fontFamily: 'Sans',
                ),
              if (betNumber >= 0)
                MyStrokeText(
                  text: '-${Lang.betNumber.trArgs(['$betNumber'])}',
                  fontSize: 15,
                  textColor: const Color(0xFFFCC151),
                  strokeWidth: 2,
                  dy: 2,
                  fontFamily: 'Sans',
                ),
            ],
          ),

          const SizedBox(height: 10),

          Container(height: 1, color: Colors.black.withValues(alpha: 0.3)),
          Container(height: 2, color: Colors.white.withValues(alpha: 0.2)),

          const SizedBox(height: 10),

          buildTextField(
            controller: amountController,
            hintText: Lang.betInputHintText.tr,
            height: 55,
            prefixIcon: SizedBox(width: 60, height: 60, child: Center(child: SizedBox(width: 30, height: 30, child: MyIcons.headerStone))),
          ),

          const SizedBox(height: 10),

          Row(children: [100000, 200000, 500000, 0].asMap().entries.map((e) {
            return Expanded(
              flex: e.key == 3 ? 3 : 4,
              child: MyButton(
                isDebounce: false,
                onPressed: () {
                  if (e.key < 4 - 1) {
                    amountController.text = '${(amountController.text.isNotEmpty ? int.parse(amountController.text) : 0) + e.value}';
                  } else {
                    amountController.text = '${UserController.to.userInfo.value.balance}';
                  }

                  widget.onChange.call(amountController.text.isNotEmpty ? int.parse(amountController.text) : 0);
                },
                child: Container(
                  margin: e.key == 3 ? null : EdgeInsets.only(right: 4),
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xFF36364A),
                  ),
                  child: Center(child: FittedBox(child: MyStrokeText(
                    text: e.key == 3 ? Lang.betAmountMax.tr : '+${e.value.toString().replaceAllMapped(
                      RegExp(r'(\d)(?=(\d{3})+$)'), (Match match) => '${match[1]},',
                    )}',
                    fontSize: 15,
                    textColor: Color(0xFFFFFFFF),
                    strokeWidth: 2,
                    dy: 0,
                  ))),
                ),
              ),
            );
          }).toList())

        ],
      ),
    );
  }
}