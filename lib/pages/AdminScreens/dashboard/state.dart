import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:grocery_app/components/colors/light_app_colors.dart';
import 'package:intl/intl.dart';
import 'package:vertical_barchart/vertical-barchartmodel.dart';

class DashBoardState {


  Rx<bool> loaded = false.obs;
  Map<String, int> orderCounts = <String, int>{}.obs;
  Map<String, int> lastWeekOrderCounts = <String, int>{}.obs;
  Map<String, int> currentWeekOrderCounts = <String, int>{}.obs;
  Map<String, int> monthlySales = <String,int>{}.obs;
  final List<String> months = List.generate(3, (index) {
    final now = DateTime.now().add(Duration(days: (1 - index) * 30));
    return DateFormat('MMM yyyy').format(now);
  }).reversed.toList(); // Reverse the list to show previous months first



  List<String> nameOfDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  int totalSales =0;
  int totalOrders = 0;
  int pendingOrders= 0;
  int shippedOrders= 0;
  int deliveredOrders= 0;
  int cancelledOrders = 0;


  Map<String, double> dataMap = {
    "Orders": 220,
    "Pending": 40,
    "Shipped" : 20,
    "Delivered": 120,
    "Cancelled": 40,
  };


  List<Color> colorList = <Color>[
    Colors.blueAccent,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.red,

  ];



}