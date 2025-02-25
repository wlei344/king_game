import 'package:get/get.dart';

class ApplicationState {
  String title = 'Application View';

  final _pageIndex = 0.obs;
  set pageIndex(int value) => _pageIndex.value = value;
  int get pageIndex => _pageIndex.value;
}