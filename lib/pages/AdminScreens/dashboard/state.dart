import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:grocery_app/components/colors/light_app_colors.dart';

class DashBoardState {


  Rx<bool> loaded = false.obs;

  int totalSales =0;
  int totalOrders = 0;
  int pendingOrders= 0;
  int deliveredOrders= 0;
  int cancelledOrders = 0;


  Map<String, double> dataMap = {
    "Orders": 200,
    "Pending": 40,
    "Delivered": 120,
    "Cancelled": 40,
  };


  List<Color> colorList = <Color>[
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.red,

  ];

}