import 'dart:ui';

import 'package:get/get.dart';
import 'package:grocery_app/pages/session_sreens/login/index.dart';
import 'package:grocery_app/pages/session_sreens/signup/state.dart';
import 'package:grocery_app/pages/user_screens/category_screen/index.dart';
import 'package:grocery_app/pages/user_screens/home_screen/index.dart';

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
      'catText' : 'HouseHold Items',
    },
    {
      'imgPath' : 'assets/pic2.jpeg',
      'catText' : 'Kitchen Items',
    },
    {
      'imgPath' : 'assets/pic3.jpeg',
      'catText' : 'Bathroom Items',
    },
    {
      'imgPath' : 'assets/pic4.jpeg',
      'catText' : 'Clothing Items',
    },
    {
      'imgPath' : 'assets/pic5.jpeg',
      'catText' : 'Beauty Items',
    },
  ];
}