import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:grocery_app/components/colors/light_app_colors.dart';
import 'package:vertical_barchart/vertical-barchartmodel.dart';

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



  List<VBarChartModel> bardata = [
    VBarChartModel(
      index: 0,
      label: "Monday",
      colors: [Colors.orange, Colors.deepOrange],
      jumlah: 30,
      tooltip: "20 Pcs",
      description: Text(
        "Most selling fruit last week",
        style: TextStyle(fontSize: 10),
      ),
    ),
    VBarChartModel(
      index: 1,
      label: "Tuesday",
      colors: [Colors.orange, Colors.deepOrange],
      jumlah: 55,
      tooltip: "55 Pcs",
      description: Text(
        "Most selling fruit this week",
        style: TextStyle(fontSize: 10),
      ),
    ),
    VBarChartModel(
      index: 2,
      label: "Wednesday",
      colors: [Colors.teal, Colors.indigo],
      jumlah: 12,
      tooltip: "12 Pcs",
    ),
    VBarChartModel(
      index: 3,
      label: "Thursday",
      colors: [Colors.teal, Colors.indigo],
      jumlah: 5,
      tooltip: "5 Pcs",
    ),
    VBarChartModel(
      index: 4,
      label: "Friday",
      colors: [Colors.orange, Colors.deepOrange],
      jumlah: 15,
      tooltip: "15 Pcs",
    ),
    VBarChartModel(
      index: 5,
      label: "Saturday",
      colors: [Colors.teal, Colors.indigo],
      jumlah: 30,
      tooltip: "30 Pcs",
      description: Text(
        "Favorites vegetables",
        style: TextStyle(fontSize: 10),
      ),
    ),
    VBarChartModel(
      index: 5,
      label: "Sunday",
      colors: [Colors.teal, Colors.indigo],
      jumlah: 30,
      tooltip: "30 Pcs",
      description: Text(
        "Favorites vegetables",
        style: TextStyle(fontSize: 10),
      ),
    ),
  ];

}