import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:king_game/common/common.dart';

void buildExchangeDialog() {
  int amount = 0;
  showMyDialog(
    header: _buildHeader(),
    body: ExchangeBody(onAmountChanged: (value) => amount = value),
    footer: _buildFooter(() => amount),
  );
}

Widget _buildHeader() {
  return Row(children: [
    SizedBox(height: MyConfig.app.alertHeaderHeight / 2, child: MyIcons.headerCard),
    SizedBox(width: 4,),
    MyStrokeText(
      text: Lang.exchangeTitle.tr,
      strokeWidth: 4,
      dy: 3,
      fontSize: 20,
      fontFamily: 'Sans',
    ),
  ]);
}

class ExchangeBody extends StatefulWidget {
  final ValueChanged<int> onAmountChanged;

  const ExchangeBody({super.key, required this.onAmountChanged});


  @override
  ExchangeBodyState createState() => ExchangeBodyState();
}

class ExchangeBodyState extends State<ExchangeBody> {
  late TextEditingController _controller;

  int _index = -1;
  final List<int> _amounts = [10, 30, 50, 100, 500];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(_listener);
  }

  void _listener() {
    int? newAmount = int.tryParse(_controller.text) ?? 0;
    widget.onAmountChanged(newAmount);

    for (int i = 0; i < _amounts.length; i++) {
      if (_controller.text == _amounts[i].toString()) {
        setState(() {
          _index = i;
        });
        return;
      }
    }

    setState(() {
      _index = -1;
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final child = Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF213F98),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 50),
          buildTextField(
            hintText: Lang.exchangeHint.tr,
            controller: _controller,
            height: 55,
            prefixIcon: SizedBox(width: 60, height: 60, child: Center(child: SizedBox(width: 30, height: 30, child: MyIcons.headerCard))),
          ),
          const SizedBox(height: 10),
          Row(children: _amounts.asMap().entries.map((item) {
            return Expanded(child: Padding(padding: item.key == _amounts.length - 1 ? EdgeInsets.zero : EdgeInsets.only(right: 4), child: buildCheckButton(
              isChecked: _index == item.key ? true : false,
              height: 40,
              onPressed: () {
                setState(() {
                  _index = item.key;
                });
                _controller.text = item.value.toString();
              },
              child: Center(child: Text(item.value.toString(), style: TextStyle(color: Colors.white))),
            )));
          }).toList()),

          const SizedBox(height: 20),

          Row(children: [
            SizedBox(height: 24, child: MyIcons.headerStone),
            MyStrokeText(
              text: '${UserController.to.userInfo.value.balance}',
              fontSize: 18,
              fontFamily: 'Sans',
            ),
          ]),

          const SizedBox(height: 20),

          Row(children: [
            Stack(children: [
              SizedBox(height: 40, child: MyIcons.inviteUrlBackgroundLeft),
              Positioned.fill(left: -5, top: -2, child: Center(child: SizedBox(height: 18, child: MyIcons.headerCard)))
            ]),
            Expanded(child: Stack(children: [
              SizedBox(height: 40, child: MyIcons.inviteUrlBackgroundMiddle),
              Positioned(left: 10, top: 0, right: 10, bottom: 0, child: Align(
                alignment: Alignment.centerLeft,
                child: Obx(() => Text('${UserController.to.userInfo.value.tickets}', style: TextStyle(fontSize: 15, color: Color(0xFF95C1F1))),
              ))),
            ])),
            SizedBox(height: 40, child: MyIcons.inviteUrlBackgroundRight),
          ]),

          const SizedBox(height: 50 + 20),
        ],
      ),
    );

    return KeyboardDismissOnTap(child: child);
  }
}

Widget _buildFooter(int Function() getAmount) {
  return buildButton(
    margin: const EdgeInsets.symmetric(vertical: 18, horizontal: 80),
    onPressed: () async {
      if (getAmount() <= 0) {
        MyAlert.showSnack(child: Text(Lang.exchangeAmountError.tr, style: TextStyle(color: Colors.white)));
        return;
      }
      Get.back();
      showMyLoading();
      await UserController.to.myDio?.post(MyApi.user.exchangeDiamond,
          data: {'amount': getAmount()},
          onSuccess: (code, msg, data) async {
            await UserController.to.userInfo.value.update();
            UserController.to.userInfo.refresh();
            MyAlert.showSnack(child: Text(msg, style: TextStyle(color: Colors.white)));
          },
          onError: (e) {
            MyAlert.showSnack(child: Text('${e.error}', style: TextStyle(color: Colors.white)));
          }
      );
      hideMyLoading();
    },
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