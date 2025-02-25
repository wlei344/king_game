import 'package:king_game/common/common.dart';
import 'package:get/get.dart';

Future<void> setLangSystem() async {
  if (Get.deviceLocale != null) {
    final myLocale = MyLangMode.fromLocale(Get.deviceLocale!);
    await MyLang.update(mode: myLocale);
  }
  await MyCache.removeFile('locale');
}

Future<void> setLangZh() async {
  final myLocale = MyLangMode.fromString('zh');
  await MyLang.update(mode: myLocale);
  await MyCache.putFile('locale', myLocale.toString());
}

Future<void> setLangEn() async {
  final myLocale = MyLangMode.fromString('en');
  await MyLang.update(mode: myLocale);
  await MyCache.putFile('locale', myLocale.toString());
}