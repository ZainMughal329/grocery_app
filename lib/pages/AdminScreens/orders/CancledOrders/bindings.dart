import 'package:get/get.dart';
import 'package:grocery_app/pages/AdminScreens/orders/CancledOrders/controller.dart';

class CanceledOrderBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<CanceledOrderController>(() => CanceledOrderController());
  }

}