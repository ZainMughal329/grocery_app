import 'package:get/get.dart';
import 'package:grocery_app/pages/AdminScreens/orders/OrderItems/controller.dart';

class OrderItemsBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<OrderItemsController>(() => OrderItemsController());
  }

}