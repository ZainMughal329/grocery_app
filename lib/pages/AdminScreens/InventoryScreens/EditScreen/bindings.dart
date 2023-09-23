import 'package:get/get.dart';
import 'package:grocery_app/pages/AdminScreens/InventoryScreens/EditScreen/controller.dart';

class EditScreenBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<EditScreenController>(() => EditScreenController());
  }

}