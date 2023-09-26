import 'package:get/get.dart';
import 'package:grocery_app/pages/AdminScreens/orders/shippedOrders/controller.dart';

class ShippedOrderBindings implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ShippedOrderController>(() => ShippedOrderController());
  }

}