import 'package:get/get.dart';
import 'package:king_game/common/models/bet_model.dart';

class BetState {
  String title = 'Bet View';

  BetType betType = BetType.bigAndSmall;

  final _gameIndex = 0.obs;
  int get gameIndex => _gameIndex.value;
  set gameIndex(int value) => _gameIndex.value = value;

  final _sessionIndex = 0.obs;
  int get sessionIndex => _sessionIndex.value;
  set sessionIndex(int value) => _sessionIndex.value = value;
}
