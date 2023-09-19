import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/reuseable/snackbar_widget.dart';
import 'package:grocery_app/components/routes/name.dart';
import 'package:grocery_app/components/services/session_controller.dart';
import 'package:grocery_app/pages/session_sreens/login/index.dart';
import 'package:grocery_app/pages/session_sreens/signup/state.dart';

class LogInController extends GetxController{
  final state = LogInState();

  LogInController();

  final auth = FirebaseAuth.instance;

  void setLoading(bool value) {
    state.loading.value = value;
  }

  Future<void> loginUser(String email, String password) async {
    setLoading(true);
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        SessionController().userId = value.user!.uid.toString();
        Snackbar.showSnackBar("Login", "Successfully");

        Get.toNamed(AppRoutes.homeScreen);

        state.emailController.clear();
        state.passController.clear();
        setLoading(false);
      }).onError((error, stackTrace) {
        Snackbar.showSnackBar("Error", error.toString());

        state.emailController.clear();
        state.passController.clear();
        setLoading(false);
      });
    } catch (e) {
      Snackbar.showSnackBar("Error", e.toString());

      state.emailController.clear();
      state.passController.clear();
      setLoading(false);
    }
  }
}
