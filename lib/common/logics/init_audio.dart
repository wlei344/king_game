import 'package:king_game/common/common.dart';

Future<void> initAudio() async {
  final audioCache = await MyCache.getFile('audio');
  final audioString = await audioCache?.readAsString();

  UserController.to.isOpenAudio = audioString == 'true' || audioString == null;
}

Future<void> openAudio() async {
  UserController.to.isOpenAudio = true;
  MyCache.putFile('audio', 'true', maxAge: MyConfig.time.cachePersistence);
}

Future<void> closeAudio() async {
  UserController.to.isOpenAudio = false;
  MyCache.putFile('audio', 'false', maxAge: MyConfig.time.cachePersistence);
}