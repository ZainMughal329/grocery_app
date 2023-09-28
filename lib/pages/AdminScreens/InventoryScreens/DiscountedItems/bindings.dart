import 'package:get/get.dart';
import 'package:grocery_app/pages/AdminScreens/InventoryScreens/DiscountedItems/controller.dart';

class DiscountedItemBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<DiscountedItemController>(() => DiscountedItemController());
  }

}