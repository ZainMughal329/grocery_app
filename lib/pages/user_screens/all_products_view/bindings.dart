import 'package:get/get.dart';
import 'package:grocery_app/pages/user_screens/cart_directory/controller.dart';
import 'package:grocery_app/pages/user_screens/faqs/controller.dart';

class AllProuctsBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllProuctsBindings>(() => AllProuctsBindings(),);
  }

}