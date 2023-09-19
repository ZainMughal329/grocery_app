import 'package:get/get.dart';
import 'package:grocery_app/pages/session_sreens/forgot/controller.dart';
import 'package:grocery_app/pages/session_sreens/login/controller.dart';
import 'package:grocery_app/pages/session_sreens/signup/controller.dart';

class ForgotBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotController>(() => ForgotController());
  }

}