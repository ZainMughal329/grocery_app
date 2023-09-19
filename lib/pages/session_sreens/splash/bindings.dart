import 'package:get/get.dart';
import 'package:grocery_app/pages/session_sreens/splash/controller.dart';

class SplashScreenBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SplashScreenController>(() => SplashScreenController());
  }

}