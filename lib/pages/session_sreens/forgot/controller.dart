import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/reuseable/snackbar_widget.dart';
import 'package:grocery_app/components/routes/name.dart';
import 'package:grocery_app/pages/session_sreens/forgot/index.dart';

class ForgotController extends GetxController{
  final state = ForgotState();

  ForgotController();

  final auth = FirebaseAuth.instance;

  void setLoading(bool value) {
    state.loading.value = value;
  }

  forgotPasswordForUser(String email) async {
    setLoading(true);
    try{
      await auth.sendPasswordResetEmail(email: email).then((value) {
        Snackbar.showSnackBar("Success", "Email Sent Successfully");
        // Get.snackbar('Success' , 'Send email successfully');
        Get.offAndToNamed(AppRoutes.logInScreen);
        state.emailController.clear();
        setLoading(false);
      }).onError((error, stackTrace) {
        Snackbar.showSnackBar("Error", error.toString());
        // print('Error occurs : ' +error.toString());
        setLoading(false);
      });
    }catch(e){
      Snackbar.showSnackBar("Error", e.toString());
    }
  }
}
