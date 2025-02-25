import 'package:get/get.dart';
import 'package:king_game/common/common.dart';

class BagState {
  String title = 'Bag View';

  final bagItems = BagItemListModel.empty().obs;
}
