import 'package:get/get.dart';
import 'package:grocery_app/pages/AdminScreens/InventoryScreens/AddItem/controller.dart';

class AddItemBindings implements Bindings{


  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<AddItemController>(() => AddItemController());
  }
}