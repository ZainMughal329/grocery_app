import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/models/item_model.dart';
import 'package:grocery_app/pages/session_sreens/login/index.dart';
import 'package:grocery_app/pages/session_sreens/signup/state.dart';
import 'package:grocery_app/pages/user_screens/home_screen/index.dart';

class HomeController extends GetxController {
  final state = HomeState();

  HomeController();

  void changeTheme(value) {
    if (value == true) {
      state.isDarkMode.value = true;
      Get.changeTheme(ThemeData.dark());
    } else {
      state.isDarkMode.value = false;
      Get.changeTheme(ThemeData.light());
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchUsername();
    _fetchCollectionData();
  }

  List<String> imagesList = [
    'assets/pic1.jpeg',
    'assets/pic2.jpeg',
    'assets/pic3.jpeg',
    'assets/pic4.jpeg',
    'assets/pic5.jpeg',
  ];

  final List<CategoryItem> category = [
    CategoryItem(
      category: 'HouseHold',
      subTitle:
          "Furniture. Appliances such as a microwave or toaster oven. Electronic equipment such as TVs and computers. Rugs. Tools for cooking and utensils for eating",
      subCategory: [
        'Cleaning',
        'Furniture',
        'Decor',
        'Laundry',
        'Dishwashing',
      ],
    ),
    CategoryItem(
      category: 'Kitchen',
      subTitle:
          ' the tools, utensils, appliances, dishes, and cookware used in food preparation, or the serving of food.',
      subCategory: [
        'Appliances',
        'Cookwares',
        'Gadgets',
        'Storage',
        'Cleaning',
      ],
    ),
    CategoryItem(
      category: 'Bathroom',
      subTitle:
          'Common bathroom organization categories include hair items, makeup, medicine, towels, nail supplies, and toiletries',
      subCategory: [
        'Hygiene',
        'Soaps',
        'Shampoos',
        'Conditioners',
        'Cleaners',
      ],
    ),
    CategoryItem(
      category: 'Clothing',
      subTitle:
          'Casual wear – worn as standard clothing. Formal wear – worn for events such as weddings. Lingerie – undergarments worn for support and / or decoration. Sportswear – worn for athletic activities like running.',
      subCategory: [
        'Men',
        'Women',
        'Kids',
        'Undergarments',
        'Specialty',
      ],
    ),
    CategoryItem(
      category: 'Grocery',
      subTitle:
          ' Fruits, vegetables , meat , sea food and freshly baked bakery items.',
      subCategory: [
        'Vegetables',
        'Fruits',
        'Meat',
        'Bakery',
        'Beverages',
      ],
    ),
  ];






  final RxList<DocumentSnapshot> documents = <DocumentSnapshot>[].obs;



  Future<void> _fetchCollectionData() async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('orderList').get();
    documents.assignAll(querySnapshot.docs);
    print('Fetched ${documents.length} documents');
  }

  int get collectionLength => documents.length;

  int calculateDiscountedPrice(int originalPrice, int? discountPercentage) {
    // Calculate the discount amount
    int discountAmount = (originalPrice * discountPercentage!) ~/ 100;

    // Calculate the discounted price
    int discountedPrice = originalPrice - discountAmount;

    return discountedPrice;
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

  Future<List<ItemModel>> getAllItemsData() async {
    final snapshot = await FirebaseFirestore.instance.collection('Items').get();
    final itemData = snapshot.docs.map((e) => ItemModel.fromJson(e)).toList();
    return itemData;
  }

  Future<List<ItemModel>> getAndShowALlItemsData() async {
    return await getAllItemsData();
  }

  isTrue(bool value) {
    state.isTrue.value = value;
    update();
  }
}
