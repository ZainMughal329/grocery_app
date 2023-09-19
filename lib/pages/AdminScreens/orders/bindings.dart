import 'package:get/get.dart';
import 'package:grocery_app/pages/AdminScreens/orders/controller.dart';

class OrdersBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<OrdersController>(() => OrdersController());
  }

}