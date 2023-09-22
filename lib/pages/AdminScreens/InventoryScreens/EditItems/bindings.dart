import 'package:get/get.dart';
import 'package:grocery_app/pages/AdminScreens/InventoryScreens/EditItems/controller.dart';

class EditItemBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<EditItemController>(() => EditItemController());
  }

}