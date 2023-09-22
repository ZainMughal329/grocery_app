import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/colors/light_app_colors.dart';
import 'package:grocery_app/pages/AdminScreens/InventoryScreens/EditItems/controller.dart';

class EditItemView extends GetView<EditItemController> {
  const EditItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: LightAppColor.bgColor,
      body: SafeArea(
          child: Text("Edit Screen")),
    );
  }
}
