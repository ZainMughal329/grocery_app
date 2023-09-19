import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/pages/AdminScreens/InventoryManagement/controller.dart';

class InventoryView extends GetView<InventoryController> {
  const InventoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Inventory Screen"),),
    );
  }
}
