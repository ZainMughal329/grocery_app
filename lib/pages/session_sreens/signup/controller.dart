import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/models/user_model.dart';
import 'package:grocery_app/components/routes/name.dart';
import 'package:grocery_app/pages/session_sreens/signup/state.dart';

class SignInController {
  SignInController();

  final state = SignInState();

  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  setLoading(bool value) {
    state.loading.value = value;
  }

  void registerUser(String email, String password, UserModel userModel) async {
    setLoading(true);
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        userModel.id = auth.currentUser!.uid.toString();
        storeUserData(userModel);
        print('created user successfully');
        state.passController.clear();
        state.userNameController.clear();
        state.emailController.clear();
        state.phoneController.clear();
        setLoading(false);
      }).onError((error, stackTrace) {
        print('Error is : ' + error.toString());
        state.passController.clear();
        state.userNameController.clear();
        state.emailController.clear();
        state.phoneController.clear();

        setLoading(false);
      });
    } catch (e) {
      Get.defaultDialog();
    }
  }

  storeUserData(UserModel userModel) async {
    setLoading(true);
    await db
        .collection('users')
        .doc(auth.currentUser!.uid)
        .set(
          userModel.toJson(),
        )
        .then((value) {
      Get.snackbar('Success', 'Store data successfully');
      Get.toNamed(AppRoutes.homeScreen);
      setLoading(false);
    }).onError((error, stackTrace) {
      Get.snackbar('Error', 'Error while store data successfully');
      setLoading(false);
    });
  }

  void validatePasswordStrength(String value) {
    // state.strength.value = estimatePasswordStrength(value);
  }

  String passwordStrengthLabel() {
    if (state.strength.value < 0.3) {
      return "Weak";
    } else if (state.strength.value < 0.7) {
      return "Fair";
    } else {
      return "Strong";
    }
  }

  bool formIsValid() {
    return (state.emailController.text.trim().isNotEmpty &&
            state.userNameController.text.trim().isNotEmpty &&
            state.phoneController.text.trim().isNotEmpty &&
            state.passController.text.trim().isNotEmpty
        // &&
        // state.strength.value >= 0.3
        ); // Add other validation rules as needed
  }
}
