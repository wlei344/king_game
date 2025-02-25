import 'package:get/get.dart';
import 'package:king_game/common/common.dart';

Future<void> initLang() async {
  // 初始化语言
  final localeCache = await MyCache.getFile('locale');
  final localeString = await localeCache?.readAsString();

  MyLangMode mode = MyLangMode.fromLocale(Get.deviceLocale ?? MyLang.defaultMode);

  if (localeString != null) {
    mode = MyLangMode.fromString(localeString);
  }

  MyLang.update(mode: mode);
}

// Future<String> getLocaleString() async {
//   final localeCache = await MyCache.getFile('locale');
//   var localeString = await localeCache?.readAsString();
//
//   MyLangMode mode = MyLangMode.fromLocale(Get.deviceLocale ?? MyLang.defaultMode);
//
//   localeString ??= mode.toString();
//
//   return localeString;
// }