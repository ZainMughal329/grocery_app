import 'package:get/get.dart';
import 'package:grocery_app/pages/user_screens/profile/index.dart';

class ProfileBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
  }

}