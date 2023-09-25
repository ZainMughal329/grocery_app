import 'package:get/get.dart';
import 'package:grocery_app/pages/AdminScreens/orders/OrderHome/controller.dart';

class OrderHomeBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<OrderHomeController>(() => OrderHomeController());
  }

}