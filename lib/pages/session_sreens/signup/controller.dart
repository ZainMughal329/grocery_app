import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/models/user_model.dart';
import 'package:grocery_app/components/reuseable/snackbar_widget.dart';
import 'package:grocery_app/components/routes/name.dart';
import 'package:grocery_app/components/services/session_controller.dart';
import 'package:grocery_app/pages/session_sreens/signup/state.dart';
import 'package:password_strength_checker/password_strength_checker.dart';

class SignInController extends GetxController {
  SignInController();

  final state = SignInState();

  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  final passNotifier = ValueNotifier<PasswordStrength?>(null);

  setLoading(bool value) {
    state.loading.value = value;
  }

  void registerUser(String email, String password, UserModel userModel) async {
    setLoading(true);
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
            SessionController().userId = value.user!.uid.toString();
        userModel.id = auth.currentUser!.uid.toString();
        storeUserData(userModel);
        // print('created user successfully');
        state.passController.clear();
        state.userNameController.clear();
        state.emailController.clear();
        state.phoneController.clear();
        passNotifier.value = null;
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
      // Get.snackbar('Success', 'Store data successfully');
      Snackbar.showSnackBar("Success", "User Created Successfully");
      Get.offAndToNamed(AppRoutes.homeScreen);
      setLoading(false);
    }).onError((error, stackTrace) {
      // Get.snackbar('Error', 'Error while store data successfully');
      Snackbar.showSnackBar("Error", error.toString());
      setLoading(false);
    });
  }

  bool formIsValid() {
    return (state.emailController.text.trim().isNotEmpty &&
        state.userNameController.text.trim().isNotEmpty &&
        state.phoneController.text.trim().isNotEmpty &&
        state.passController.text.trim().isNotEmpty &&
        passNotifier.value != PasswordStrength.weak &&
        passNotifier.value !=
            PasswordStrength
                .alreadyExposed); // Add other validation rules as needed
  }
}
