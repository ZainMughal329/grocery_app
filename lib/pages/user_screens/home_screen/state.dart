import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class HomeState {
  final searchController = TextEditingController();
  RxBool isDarkMode = false.obs;
  RxString username = RxString('');

}