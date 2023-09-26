import 'package:get/get.dart';
import 'package:grocery_app/pages/AdminScreens/orders/pendingOrders/controller.dart';

class PendingOrderBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<PendingOrderController>(() => PendingOrderController());
  }

}