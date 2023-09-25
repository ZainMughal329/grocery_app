import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/models/order_model.dart';
import 'package:grocery_app/pages/session_sreens/login/index.dart';
import 'package:grocery_app/pages/session_sreens/signup/state.dart';
import 'package:grocery_app/pages/user_screens/category_screen/index.dart';
import 'package:grocery_app/pages/user_screens/faqs/index.dart';
import 'package:grocery_app/pages/user_screens/home_screen/index.dart';
import 'package:grocery_app/pages/user_screens/wishList_screen/index.dart';

class WishListController extends GetxController {
  final state = WishListState();

  WishListController();

  Future<List<OrderModel>> getAllFavouriteItemsData() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('wishList')
        .get();
    final itemData = snapshot.docs.map((e) => OrderModel.fromJson(e)).toList();
    return itemData;
  }

  Future<List<OrderModel>> getAndShowALlFavouriteItemsData() async {
    return await getAllFavouriteItemsData();
  }

  int calculateDiscountedPrice(int originalPrice, int? discountPercentage) {
    // Calculate the discount amount
    int discountAmount = (originalPrice * discountPercentage!) ~/ 100;

    // Calculate the discounted price
    int discountedPrice = originalPrice - discountAmount;

    return discountedPrice;
  }

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
