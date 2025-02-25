import 'package:get/get.dart';
import 'package:king_game/common/common.dart';

class StoreState {
  String title = 'Store View';

  final skins = SkinListModel.empty().obs;
}
