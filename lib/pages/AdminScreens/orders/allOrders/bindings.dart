import 'package:get/get.dart';
import 'package:grocery_app/pages/AdminScreens/orders/OrderDetail/bindings.dart';
import 'package:grocery_app/pages/AdminScreens/orders/OrderDetail/controller.dart';
import 'package:grocery_app/pages/AdminScreens/orders/allOrders/controller.dart';
// import 'package:grocery_app/pages/AdminScreens/orders/controller.dart';

class OrdersBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<OrdersController>(() => OrdersController());
  }

}