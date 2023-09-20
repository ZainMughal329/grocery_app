import 'package:get/get.dart';
import 'package:grocery_app/pages/session_sreens/login/controller.dart';
import 'package:grocery_app/pages/session_sreens/signup/controller.dart';
import 'package:grocery_app/pages/user_screens/category_screen/index.dart';
import 'package:grocery_app/pages/user_screens/home_screen/controller.dart';

class HelpCenterBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HelpCenterBindings>(() => HelpCenterBindings());
  }

}