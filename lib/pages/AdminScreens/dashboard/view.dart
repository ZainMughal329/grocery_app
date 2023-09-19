import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/pages/AdminScreens/dashboard/controller.dart';

class DashBoardView extends GetView<DashBoardController> {
  const DashBoardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Text("DashBoard"),),
    );
  }
}
