import 'package:get/get.dart';
import 'package:grocery_app/pages/user_screens/checkOut_screen/controller.dart';

class CheckOutBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<CheckOutController>(() => CheckOutController());
  }

}