import 'package:get/get.dart';
import 'package:grocery_app/pages/session_sreens/signup/controller.dart';

class SignInBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(() => SignInController());
  }

}