import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:grocery_app/pages/session_sreens/login/index.dart';
import 'package:grocery_app/pages/session_sreens/signup/state.dart';
import 'package:grocery_app/pages/user_screens/home_screen/index.dart';

class HomeController extends GetxController {
  final state = HomeState();

  HomeController();

  void toggleTheme() {
    state.isDarkMode.value = !state.isDarkMode.value;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchUsername();
  }

  // Function to fetch the username of a specific user.
  Future<void> fetchUsername() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        final fetchedUsername = data['userName'] as String;
        state.username.value = fetchedUsername;
      } else {
        state.username.value =
            'Guest User'; // User not found or document doesn't exist.
      }
    } catch (error) {
      // Handle any potential errors here.
      print('Error fetching username: $error');
    }
  }
}
