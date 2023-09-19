import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/routes/name.dart';
import 'package:grocery_app/pages/session_sreens/forgot/index.dart';

class ForgotController {
  final state = ForgotState();

  ForgotController();

  final auth = FirebaseAuth.instance;

  void setLoading(bool value) {
    state.loading.value = value;
  }

  forgotPasswordForUser(String email) async {
    setLoading(true);
    await auth.sendPasswordResetEmail(email: email).then((value) {
      Get.snackbar('Success' , 'Send email successfully');
      Get.offAndToNamed(AppRoutes.logInScreen);
      state.emailController.clear();
      setLoading(false);
    }).onError((error, stackTrace) {
      print('Error occurs : ' +error.toString());
      setLoading(false);
    });
  }
}
