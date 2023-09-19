import 'package:get/get.dart';
import 'package:grocery_app/pages/AdminScreens/AdminHome/controller.dart';

class AdminHomeBindings implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<AdminHomeController>(() => AdminHomeController());
  }

}