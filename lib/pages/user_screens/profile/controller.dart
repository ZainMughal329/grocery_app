import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:grocery_app/components/services/session_controller.dart';
import 'package:grocery_app/pages/user_screens/profile/index.dart';

import '../../../components/models/user_model.dart';
import '../../../components/reuseable/snackbar_widget.dart';

class ProfileController extends GetxController {
  final state = ProfileState();

  ProfileController();

  final auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  setLoading(bool value) {
    state.loading.value = value;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserData() {
    return _db
        .collection('users')
        .doc(auth.currentUser!.uid.toString())
        .snapshots();
  }

  // for updating user
  updateUserData(UserModel user) async {
    setLoading(true);
    await _db
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update(
          user.toJson(),
        )
        .then((value) {
      setLoading(false);
      Snackbar.showSnackBar('Update', 'Successfully Updated');
    }).onError((error, stackTrace) {
      setLoading(false);
      Snackbar.showSnackBar(
        'Error',
        error.toString().trim(),
      );
    });
  }

  updateUser(UserModel user) async {
    await updateUserData(user);
  }
}
