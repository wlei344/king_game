import 'package:get/get.dart';
import 'package:king_game/common/common.dart';

class LotteryState {
  String title = 'Lottery View';

  bool isOpeningBox = false;

  final turntablePrizes = TurntablePrizeListModel.empty().obs;
  final result = TurntableResultModel.empty();
  final skin = BoxResultModel.empty();

  final _turntableIndex = 1.obs;
  int get turntableIndex => _turntableIndex.value;
  set turntableIndex(int value) => _turntableIndex.value = value;

  final _boxIndex = 1.obs;
  int get boxIndex => _boxIndex.value;
  set boxIndex(int value) => _boxIndex.value = value;

  final _gameIndex = 0.obs;
  int get gameIndex => _gameIndex.value;
  set gameIndex(int value) => _gameIndex.value = value;

  final _isDisabled = true.obs;
  bool get isDisabled => _isDisabled.value;
  set isDisabled(bool value) => _isDisabled.value = value;
}
