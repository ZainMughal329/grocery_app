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
  }

  List<String> imagesList = [
    'assets/pic5.jpeg',
    'assets/4.jpg',
    'assets/3.png',
    'assets/1.png',
    'assets/2.png',
  ];

  final List<CategoryItem> category = [
    CategoryItem(
      category: 'HouseHold',
      subTitle:
          "Furniture,appliances,Electronic equipment,rugs,Tools,utensils and many more",
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
          'Tools,utensils,appliances,dishes,cookware and many more.',
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
          'Common bathroom items,makeup,medicine,toiletries and many more',
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
          'Casual wear,Formal wear,Lingerie,Sportswear and many more.',
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
          ' Fruits,vegetables,meat,sea-food and many more.',
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




  int get collectionLength => documents.length;



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
