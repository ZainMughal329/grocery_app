import 'package:get/get.dart';
import 'package:grocery_app/pages/AdminScreens/dashboard/controller.dart';

class DashBoardBindings implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<DashBoardController>(() => DashBoardController());
  }

}