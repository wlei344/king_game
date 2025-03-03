import 'package:audioplayers/audioplayers.dart';
import 'package:king_game/common/common.dart';

enum MyAudioPath {
  achievement('audios/achievement.mp3'),
  click('audios/click.mp3'),
  coinDrop('audios/coin_drop.mp3'),
  dialog('audios/dialog.mp3'),
  news('audios/news.mp3'),
  scan('audios/scan.mp3'),
  setting('audios/setting.mp3'),
  exchangeSuccessful('audios/exchange_successful.mp3'),
  exchangeFailed('audios/exchange_failed.mp3');

  final String path;
  const MyAudioPath(this.path);
}

class MyAudio {
  static final MyAudio _instance = MyAudio._internal();
  factory MyAudio() => _instance;
  MyAudio._internal();

  static Future<void> play(MyAudioPath audioPath) => _instance._play(audioPath);

  final Map<MyAudioPath, AudioPlayer> _audioPlayers = {};

  Future<void> _play(MyAudioPath audioPath) async {
    if (!UserController.to.isOpenAudio) return;

    if (!_audioPlayers.containsKey(audioPath)) {
      // 如果 AudioPlayer 不存在，创建并缓存
      final player = AudioPlayer();
      player.play(AssetSource(audioPath.path));
      _audioPlayers[audioPath] = player;
      await player.setSource(AssetSource(audioPath.path));
      await player.setReleaseMode(ReleaseMode.stop);
    } else {
      // 如果已存在，直接播放
      final player = _audioPlayers[audioPath]!;
      if (player.state == PlayerState.playing) {
        await player.stop();
      }
      player.resume();
    }
  }
}