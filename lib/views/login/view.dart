import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:king_game/common/common.dart';

import 'controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    double paddingHorizontal = Get.width * 0.16;

    if(kIsWeb || Get.width > MyConfig.app.webBodyMaxWidth) {
      paddingHorizontal = Get.width.clamp(200, MyConfig.app.webBodyMaxWidth) * 0.16;
    }

    final body = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(children: [
          const SizedBox(height: 24),
          Padding(padding: EdgeInsets.symmetric(horizontal: paddingHorizontal), child: SizedBox(width: double.infinity, child: MyIcons.logo)),
        ]),

        Column(children: [
          buildTextField(
            hintText: Lang.loginViewAccount.tr,
            controller: controller.accountController,
            margin: EdgeInsets.symmetric(horizontal: paddingHorizontal / 2),
            height: 55,
            prefixIcon: SizedBox(width: 60, height: 60, child: Center(child: SizedBox(width: 30, height: 30, child: MyIcons.loginPhone))),
          ),

          const SizedBox(height: 10),

          buildTextField(
            hintText: Lang.loginViewEmail.tr,
            controller: controller.codeController,
            margin: EdgeInsets.symmetric(horizontal: paddingHorizontal / 2),
            height: 55,
            prefixIcon: SizedBox(width: 60, height: 60, child: Center(child: SizedBox(width: 30, height: 30, child: MyIcons.loginEmail,),)),
            suffixIcon: Obx(() => TextButton(
              onPressed: controller.state.captchaCountdown >= 60 ? controller.sendCode : null,
              style: ButtonStyle(
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              ),
              child: Text(controller.state.captchaCountdown >= 60 ? Lang.loginViewSendCode.tr : '${controller.state.captchaCountdown}', style: TextStyle(color: Color(0XFF397DEA))),
            )),
          ),

          const SizedBox(height: 10),

          buildButton(
            margin: EdgeInsets.symmetric(horizontal: paddingHorizontal / 2),
            onPressed: controller.onLogin,
            height: 55,
            shadowColor: Color(0XFF63A56F),
            colors: [Color(0XFF77FE81), Color(0XFF7CEE63)],
            child: MyStrokeText(
              text: Lang.loginViewSignInForAccount.tr,
              fontFamily: 'Sans',
              fontSize: 20,
              strokeWidth: 3,
              strokeColor: Color(0xFF4D4D4D),
              shadowColor: Color(0xFF4D4D4D),
              dy: 3,
            ),
          ),
        ]),

        Container(
          padding: EdgeInsets.symmetric(horizontal: paddingHorizontal / 2),
          height: 200,
          width: double.infinity,
          color: Colors.black.withValues(alpha: 0.5),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(children: [
              Expanded(child: _buildButton(
                context: context,
                onPressed: controller.onLoginForGoogle,
                height: 45,
                child: FittedBox(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SizedBox(width: 20, height: 20, child: MyIcons.loginGoogle),
                  SizedBox(width: 10),
                  Text(Lang.loginViewGoogle.tr, style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600)),
                ],),),
              ),),

              const SizedBox(width: 10,),

              Expanded(child: _buildButton(
                context: context,
                onPressed: controller.onLoginForFacebook,
                height: 45,
                child: FittedBox(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SizedBox(width: 23, height: 23, child: MyIcons.loginFacebook),
                  SizedBox(width: 10),
                  Text(Lang.loginViewFacebook.tr, style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600)),
                ],),),
              ),),
            ],),

            const SizedBox(height: 10),

            _buildButton(
              context: context,
              onPressed: controller.onGuestLogin,
              height: 45,
              child: FittedBox(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(width: 23, height: 23, child: MyIcons.loginGuest),
                SizedBox(width: 10),
                Text(Lang.loginViewGuest.tr, style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600)),
              ],),),
            ),
          ],),
        ),
      ],
    );

    return KeyboardDismissOnTap(child: Stack(alignment: AlignmentDirectional.topCenter, children: [
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: MyIcons.loginBackground,
            fit: BoxFit.cover,
          ),
        ),
      ),
      Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(backgroundColor: Colors.black.withAlpha(0),),
        body: body,
      ),
    ]));
  }



  Widget _buildButton({
    required BuildContext context,
    void Function()? onPressed,
    EdgeInsetsGeometry? margin,
    double? height,
    Widget? child,
  }) {
    final borderRadius = BorderRadius.circular(10);

    final body = Container(
      margin: margin,
      height: height,
      decoration: BoxDecoration(
          color: Color(0XFFDDDDDD),
          borderRadius: borderRadius,
          border: Border.all(color: Colors.black, width: 2),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black,
          //     offset: Offset(0, 2),
          //   ),
          // ]
      ),
      clipBehavior: Clip.antiAlias,
      child: LayoutBuilder(builder: (context, constraints) => Stack(alignment: AlignmentDirectional.topCenter, children: [
        Container(
          height: constraints.maxHeight - 4,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: borderRadius * 0.8,
          ),
          child: Padding(padding: EdgeInsets.fromLTRB(4, 4, 4, 0), child: Container(
            alignment: Alignment.topLeft,
            width: constraints.maxWidth,
            height: (constraints.maxHeight - 4) / 2,
            decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.4),
                borderRadius: BorderRadius.only(
                  topLeft: borderRadius.copyWith().topLeft,
                  topRight: borderRadius.copyWith().topRight,
                ),
                shape: BoxShape.rectangle
            ),
            clipBehavior: Clip.antiAlias,
            child: Container(
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),),
          // child: textField,
        ),
        Positioned.fill(child: Center(child: Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: child))),
      ],),),
    );

    return MyButton(onPressed: onPressed, child: body);
  }
}
