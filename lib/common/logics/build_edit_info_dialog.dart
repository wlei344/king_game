import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:king_game/common/common.dart';

Future<void> buildEditInfoDialog() async {
  return showMyDialog(
    header: _buildHeader(),
    body: _buildBody(),
  );
}

Widget _buildHeader() {
  return MyStrokeText(
    text: Lang.userInfoTitle.tr,
    strokeWidth: 4,
    dy: 3,
    fontSize: 20,
    fontFamily: 'Sans',
  );
}

Widget _buildBody() {
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
        Stack(children: [
          SizedBox(height: 80, child: MyIcons.headerAvatarBackground),
          Positioned.fill(child: Padding(padding: EdgeInsets.fromLTRB(3, 3, 3, 6), child: MyIcons.headerAvatar)),
        ]),

        SizedBox(height: 10),

        EditInfoBody(),

        SizedBox(height: 10),
      ]),
    )),
  );
}

class EditInfoBody extends StatefulWidget {
  const EditInfoBody({super.key});

  @override
  EditInfoState createState() => EditInfoState();
}

class EditInfoState extends State<EditInfoBody> {
  late TextEditingController _nickNameController;
  late TextEditingController _realNameController;
  late TextEditingController _numberNameController;

  late String _bank;
  late BankListModel _bankList;

  int _bankId = -1;

  @override
  void initState() {
    super.initState();
    _nickNameController = TextEditingController();
    _realNameController = TextEditingController();
    _numberNameController = TextEditingController();

    _bank = Lang.userInfoBankNameChoice.tr;
    _bankList = BankListModel.empty();

    _loadBankList();

    _nickNameController.addListener(_listener);
    _realNameController.addListener(_listener);
    _numberNameController.addListener(_listener);

    initData();
  }

  void initData() {
    final userInfo = UserController.to.userInfo.value;

    if (userInfo.nickname.isNotEmpty) {
      _nickNameController.text = userInfo.nickname;
    }

    if (userInfo.accountName.isNotEmpty) {
      _realNameController.text = userInfo.accountName;
    }

    if (userInfo.cardNumber.isNotEmpty) {
      _numberNameController.text = userInfo.cardNumber;
    }

    if (userInfo.bankName.isNotEmpty) {
      setState(() {
        _bank = userInfo.bankName;
      });
    }
  }

  void _listener() {

  }

  Future<void> _loadBankList() async {
    await _bankList.update();
    if (mounted) {
      setState(() {
        _bankList = _bankList;
      });
    }
  }

  Future<void> _updateUserInfo({
    required int userId,
    required String nickname,
  }) async {
    await UserController.to.myDio?.post(MyApi.user.updateInfo,
      data: {
        'userId': userId,
        'nickname': nickname,
      },
      onError: (e) {
        MyAlert.showSnack(child: Text('${e.error}', style: TextStyle(color: Colors.white)));
      },
      onSuccess: (code, msg, data) async {
        await UserController.to.userInfo.value.update();
        UserController.to.userInfo.refresh();
        MyAlert.showSnack(child: Text(msg, style: TextStyle(color: Colors.white)));
      }
    );
  }

  Future<void> _updateBankInfo({
    required int userId,
    required String accountName,
    required String cardNumber,
    required int bankId,
  }) async {
    await UserController.to.myDio?.post(MyApi.user.updateBankInfo,
        data: {
          'userId': userId,
          'accountName': accountName,
          'cardNumber': cardNumber,
          'bankId': bankId,
        },
        onError: (e) {
          MyAlert.showSnack(child: Text('${e.error}', style: TextStyle(color: Colors.white)));
        },
        onSuccess: (code, msg, data) async {
          await UserController.to.userInfo.value.update();
          UserController.to.userInfo.refresh();
          MyAlert.showSnack(child: Text(msg, style: TextStyle(color: Colors.white)));
        }
    );
  }



  @override
  void dispose() {
    _nickNameController.removeListener(_listener);
    _realNameController.removeListener(_listener);
    _numberNameController.removeListener(_listener);

    _nickNameController.dispose();
    _realNameController.dispose();
    _numberNameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final child = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(width: double.infinity),
      MyStrokeText(
        text: Lang.userInfoNickNameTitle.tr,
        fontFamily: 'Sans',
      ),
      SizedBox(height: 4),
      buildTextField(
        hintText: Lang.userInfoInputHint.tr,
        controller: _nickNameController,
        textAlign: TextAlign.end,
        keyboardType: TextInputType.emailAddress,
        prefixIcon: IntrinsicWidth(child: Container(padding: EdgeInsets.symmetric(horizontal: 10), child: Center(child: Text(Lang.userInfoNickNameHint.tr)))),
      ),

      SizedBox(width: double.infinity, height: 20),
      MyStrokeText(
        text: Lang.userInfoBankTitle.tr,
        fontFamily: 'Sans',
      ),
      SizedBox(height: 4),
      buildTextField(
        hintText: Lang.userInfoInputHint.tr,
        controller: _realNameController,
        textAlign: TextAlign.end,
        keyboardType: TextInputType.text,
        prefixIcon: IntrinsicWidth(child: Container(padding: EdgeInsets.symmetric(horizontal: 10), child: Center(child: Text(Lang.userInfoRealNameHint.tr)))),
      ),

      SizedBox(height: 4),
      buildTextField(
        hintText: Lang.userInfoInputHint.tr,
        controller: _numberNameController,
        textAlign: TextAlign.end,
        keyboardType: TextInputType.number,
        prefixIcon: IntrinsicWidth(child: Container(padding: EdgeInsets.symmetric(horizontal: 10), child: Center(child: Text(Lang.userInfoBankNumberHint.tr)))),
      ),

      SizedBox(height: 4),
      MyButton(onPressed: _bankList.list.isEmpty ? null : () {
        Get.bottomSheet(Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
          ),
          child: SafeArea(child: Padding(padding: EdgeInsets.fromLTRB(24, 32, 24, 0), child: SingleChildScrollView(child: Column(children: _bankList.list.asMap().entries.map((item) => MyButton(onPressed: () {
            _bankId = item.value.id;
            setState(() {
              _bank = item.value.bankName;
            });
            Get.back();
          }, child: Container(
            height: 50,
            width: double.infinity,
            margin: item.key == _bankList.list.length -1 ? null : EdgeInsets.only(bottom: 4),
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: item.value.bankName == _bank ? Color(0xFF45F9EE) : Color(0xFFEEEEEE),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(item.value.bankName),
              if (item.value.bankName == _bank)
                SizedBox(height: 12, child: MyIcons.editSure),
            ]),
          ))).toList())))),
        ));
      }, child: Container(
        height: 55.0,
        decoration: BoxDecoration(
          color: Color(0XFFDDDDDD),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 2),
        ),
        clipBehavior: Clip.antiAlias,
        child: LayoutBuilder(builder: (context, constraints) => Align(alignment: Alignment.topLeft, child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          width: constraints.maxWidth,
          height: constraints.maxHeight - 4,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10) * 0.8,
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Flexible(child: FittedBox(child: Text(Lang.userInfoBankNameHint.tr))),
            SizedBox(width: 4),

            Row(children: [
              Text(_bank),
              SizedBox(width: 4),
              Icon(Icons.arrow_drop_down),
            ])
          ]),
        ))),
      )),

      SizedBox(height: 8),
      Row(children: [
        Expanded(child: _buildButton(onPressed: () {
          Get.back();
        }, icon: SizedBox(height: 26, child: MyIcons.editCancel))),
        SizedBox(width: 8),
        Expanded(child: _buildButton(onPressed: () {
          Get.back();
          showMyLoading();
          Future.wait([
            _updateUserInfo(
              userId: UserController.to.userInfo.value.id,
              nickname: _nickNameController.text,
            ),
            _updateBankInfo(
              userId: UserController.to.userInfo.value.id,
              accountName: _realNameController.text,
              cardNumber: _numberNameController.text,
              bankId: _bankId,
            ),
          ]);
          hideMyLoading();
        }, icon: SizedBox(height: 18, child: MyIcons.editSure))),
      ]),

      SizedBox(height: 20),

      Center(child: MyStrokeText(
        text: 'ID: ${UserController.to.userInfo.value.id}',
        fontFamily: 'Sans',
      )),
    ]);

    return KeyboardDismissOnTap(child: child);
  }
}

Widget _buildButton({
  required VoidCallback onPressed,
  required Widget icon,
}) {
  final child = Container(
    height: 44.0,
    decoration: BoxDecoration(
      color: Color(0xFF45F9EE),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Center(child: icon),
  );

  return MyButton(onPressed: onPressed, child: child);
}