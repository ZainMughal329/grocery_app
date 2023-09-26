import 'package:get/get.dart';
import 'package:grocery_app/pages/AdminScreens/orders/DelieveredOrders/controller.dart';

class DeliveredOrderBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<DeliveredOrderController>(DeliveredOrderController());
  }

}