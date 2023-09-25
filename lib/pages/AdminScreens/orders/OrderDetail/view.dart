import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/pages/AdminScreens/orders/OrderDetail/controller.dart';

class OrderDetailView extends GetView<OrderDetailController> {
  String orderId;
   OrderDetailView({Key? key,required this.orderId}) : super(key: key);
   final controller = Get.put<OrderDetailController>(OrderDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(orderId),
    );
  }
}
