import 'package:get/get.dart';
import 'package:grocery_app/pages/AdminScreens/orders/OrderDetail/controller.dart';

class OrderDetailsBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<OrderDetailController>(() => OrderDetailController());
  }

}