import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:grocery_app/pages/session_sreens/login/index.dart';
import 'package:grocery_app/pages/session_sreens/signup/state.dart';
import 'package:grocery_app/pages/user_screens/category_screen/index.dart';
import 'package:grocery_app/pages/user_screens/home_screen/index.dart';

import '../../../components/models/item_model.dart';
import '../../../components/models/order_model.dart';

class CategoryController extends GetxController {
  final state = CategoryState();

  CategoryController();
  List<Color> gridColors = [
    const Color(0xff53B175),
    const Color(0xffF8A44C),
    const Color(0xffF7A593),
    const Color(0xffD3B0E0),
    const Color(0xffB7DFF5),

  ];

  List<Map<String , dynamic>> catInfo = [
    {
      'imgPath' : 'assets/pic1.jpeg',
      'catText' : 'HouseHold',
    },
    {
      'imgPath' : 'assets/pic2.jpeg',
      'catText' : 'Kitchen',
    },
    {
      'imgPath' : 'assets/pic3.jpeg',
      'catText' : 'Bathroom',
    },
    {
      'imgPath' : 'assets/pic4.jpeg',
      'catText' : 'Clothing',
    },
    {
      'imgPath' : 'assets/pic5.jpeg',
      'catText' : 'Grocery',
    },
  ];

  final List<void Function()> pressButton = [
    () {
    print('1');
    },
        () {
      print('2');
    },
        () {
      print('3');
    },
        () {
      print('4');
    },
        () {
      print('5');
    },
  ];

  final items =
  FirebaseFirestore.instance.collection('Items').snapshots();

  Future<List<ItemModel>> getAllItemsData() async {
    final snapshot =
    await FirebaseFirestore.instance.collection('Items').get();
    final itemData = snapshot.docs.map((e) => ItemModel.fromJson(e)).toList();
    return itemData;
  }

  Future<List<ItemModel>> getAndShowALlItemsData() async {
    return await getAllItemsData();
  }




  int calculateDiscountedPrice(int originalPrice, int? discountPercentage) {
    // Calculate the discount amount
    int discountAmount = (originalPrice * discountPercentage!) ~/ 100;

    // Calculate the discounted price
    int discountedPrice = originalPrice - discountAmount;

    return discountedPrice;
  }
}