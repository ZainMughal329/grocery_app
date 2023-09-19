import 'package:get/get.dart';
import 'package:grocery_app/pages/AdminScreens/InventoryManagement/controller.dart';

class InventoryBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<InventoryController>(() => InventoryController());
  }

}