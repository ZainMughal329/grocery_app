import 'package:get/get.dart';
import 'package:grocery_app/pages/session_sreens/login/controller.dart';
import 'package:grocery_app/pages/session_sreens/signup/controller.dart';
import 'package:grocery_app/pages/user_screens/category_screen/index.dart';
import 'package:grocery_app/pages/user_screens/faqs/controller.dart';
import 'package:grocery_app/pages/user_screens/home_screen/controller.dart';
import 'package:grocery_app/pages/user_screens/order_view/controller.dart';
import 'package:grocery_app/pages/user_screens/wishList_screen/controller.dart';

class OrderBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderController>(() => OrderController());
  }

}