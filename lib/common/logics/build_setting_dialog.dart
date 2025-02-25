import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_game/common/common.dart';
import 'package:my_device_info/my_device_info.dart';

Future<void> buildSettingDialog() async {
  final lang = Lang.settingLang.tr.obs;
  final audio = Lang.settingAudio.tr.obs;
  final version = Lang.settingVersion.tr.obs;
  final logout = Lang.settingLoginOut.tr.obs;
  
  final versionInfo = await MyDeviceInfo.getDeviceInfo();

  return showMyDialog(
    header: Obx(() => MyStrokeText(
      text: lang.value,
      strokeWidth: 4,
      dy: 3,
      fontSize: 20,
      fontFamily: 'Sans',
    )),
    body: Container(padding: EdgeInsets.fromLTRB(8, 0, 8, 8), child: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: MyIcons.alertBodyBackground,
          repeat: ImageRepeat.repeat,
        ),
      ),
      child: Container(padding: EdgeInsets.fromLTRB(16, MyConfig.app.alertHeaderHeight / 2 + 16, 16, 16), child: SingleChildScrollView(
        child: Column(children: [
          buildOutlineBox(
            height: 115,
            color: Color(0xFF112A52).withValues(alpha: 0.7),
            borderColor: Color(0xFF3FB5EB),
            radius: 10,
            width: double.infinity,
            // height: 90,
            child: Column(children: [
              Row(children: [
                SizedBox(width: 24, child: MyIcons.settingButtonLang),
                SizedBox(width: 8),
                Obx(() => MyStrokeText(
                  text: lang.value,
                  strokeWidth: 4,
                  dy: 4,
                  fontSize: 16,
                )),
              ]),
              SizedBox(height: 16),
              Row(children: [
                Expanded(child: Obx(() => _buildLanguageButton(
                  isChecked: UserController.to.localeString == MyLangMode.zh.toString(),
                  text: '简体中文',
                  icon: MyIcons.langCn,
                  onPressed: () {
                    MyLang.update(mode: MyLangMode.zh);
                    lang.value = Lang.settingLang.tr;
                    lang.refresh();
                    audio.value = Lang.settingAudio.tr;
                    audio.refresh();
                    version.value = Lang.settingVersion.tr;
                    version.refresh();
                    logout.value = Lang.settingLoginOut.tr;
                    logout.refresh();
                  },
                  height: 36,
                ))),

                const SizedBox(width: 8),
                Expanded(child: Obx(() => _buildLanguageButton(
                  isChecked: UserController.to.localeString == MyLangMode.en.toString(),
                  text: 'English',
                  icon: MyIcons.langEn,
                  onPressed: () {
                    MyLang.update(mode: MyLangMode.en);
                    lang.value = Lang.settingLang.tr;
                    lang.refresh();
                    audio.value = Lang.settingAudio.tr;
                    audio.refresh();
                    version.value = Lang.settingVersion.tr;
                    version.refresh();
                    logout.value = Lang.settingLoginOut.tr;
                    logout.refresh();
                  },
                  height: 36,
                ))),
                const SizedBox(width: 8),
                Expanded(child: Obx(() => _buildLanguageButton(
                  isChecked: UserController.to.localeString == MyLangMode.vi.toString(),
                  text: 'Tiếng Việt',
                  icon: MyIcons.langVn,
                  onPressed: () {
                    MyLang.update(mode: MyLangMode.vi);
                    lang.value = Lang.settingLang.tr;
                    lang.refresh();
                    audio.value = Lang.settingAudio.tr;
                    audio.refresh();
                    version.value = Lang.settingVersion.tr;
                    version.refresh();
                    logout.value = Lang.settingLoginOut.tr;
                    logout.refresh();
                  },
                  height: 36,
                ))),
              ],)
            ]),
          ),

          SizedBox(height: 12),

          buildOutlineBox(
            height: 55,
            color: Color(0xFF112A52).withValues(alpha: 0.7),
            borderColor: Color(0xFF3FB5EB),
            radius: 10,
            width: double.infinity,
            child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              SizedBox(width: 24, child: MyIcons.settingButtonAudio),
              SizedBox(width: 8),
              Obx(() => MyStrokeText(
                text: audio.value,
                strokeWidth: 4,
                dy: 4,
                fontSize: 16,
              )),
              Spacer(),
              MyButton(
                onPressed: () => UserController.to.isOpenAudio ? closeAudio() : openAudio(),
                child: SizedBox(
                  width: 70,
                  child: Obx(() => UserController.to.isOpenAudio
                      ? Stack(children: [
                    MyIcons.switchOn,
                    Positioned.fill(left: 40, right: 7, child: Center(child: FittedBox(child: Text(
                        Lang.settingAudioOn.tr
                    ))))
                  ])
                      : Stack(children: [
                    MyIcons.switchOff,
                    Positioned.fill(left: 7, right: 40, child: Center(child: FittedBox(child: Text(
                        Lang.settingAudioOff.tr
                    ))))
                  ]),
                  ),
                ),
              ),
            ]),
          ),

          SizedBox(height: 12),

          buildItemButton(
            width: double.infinity,
            height: 55,
            color: Color(0xFF04173D),
            child: Padding(padding: EdgeInsets.fromLTRB(14, 0, 14, 0), child: Align(alignment: Alignment.centerLeft, child: Row(children: [
              SizedBox(width: 24, child: MyIcons.settingButtonVersion),
              SizedBox(width: 8),
              Obx(() => MyStrokeText(
                text: version.value,
                strokeWidth: 4,
                dy: 4,
                fontSize: 16,
              )),
              Spacer(),
              Text(versionInfo.appVersion, style: TextStyle(
                color: Color(0xFF95C1F1),
                fontSize: 14,
              )),
            ])))
          ),

          SizedBox(height: 8),

          MyButton(onPressed: onLogOUt, child: buildItemButton(
            width: double.infinity,
            height: 55,
            color: Color(0xFF04173D),
            child: Padding(padding: EdgeInsets.fromLTRB(14, 0, 14, 0), child: Align(alignment: Alignment.centerLeft, child: Row(children: [
              SizedBox(width: 24, child: MyIcons.settingButtonLoginOut),
              SizedBox(width: 8),
              Obx(() => Text(logout.value, style: TextStyle(
                color: Color(0xFFF64A4A),
                fontSize: 16,
              ))),
            ]))),
          )),
        ]),
      )),
    )),
  );
}


Widget _buildLanguageButton({
  required bool isChecked,
  required String text,
  required Widget icon,
  void Function()? onPressed,
  required double height,
}) {
  final body = Container(
    height: height,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isChecked ? Colors.white : Color(0xFF36364A),
        border: isChecked ? null : Border.all(color: Colors.black, width: 2),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 0,
            spreadRadius: 0,
            color: Color(0xFF36364A),
          ),
        ]
    ),
    child: Padding(padding: EdgeInsets.fromLTRB(4, 0, 4, 0), child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(width: height * 0.6, child: icon),
      SizedBox(width: 4),
      Flexible(child: FittedBox(child: isChecked
          ? Text(text, style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w600
      ))
          : MyStrokeText(
        text: text,
        strokeWidth: 2,
        dy: 0,
        fontSize: 14,
      ),
      ))
    ]))),
  );

  return MyButton(onPressed: isChecked ? null : onPressed, child: Stack(clipBehavior: Clip.none, children: [
    body,
    Positioned(right: -8, top: -8, child: SizedBox(width: 20, child: isChecked ? MyIcons.langChecked : null))
  ]));
}