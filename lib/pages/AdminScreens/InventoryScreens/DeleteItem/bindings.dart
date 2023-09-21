import 'package:get/get.dart';
import 'package:grocery_app/pages/AdminScreens/InventoryScreens/DeleteItem/controller.dart';

class DeleteItemBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<DeleteItemController>(() => DeleteItemController());
  }

}