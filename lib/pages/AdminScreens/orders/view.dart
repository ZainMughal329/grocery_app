import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/pages/AdminScreens/orders/controller.dart';

class OrdersView extends GetView<OrdersController> {
  const OrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Orders Screen"),
    );
  }
}
