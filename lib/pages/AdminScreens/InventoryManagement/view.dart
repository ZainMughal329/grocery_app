import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/colors/light_app_colors.dart';
import 'package:grocery_app/components/reuseable/inventory_widget.dart';
import 'package:grocery_app/components/routes/name.dart';
import 'package:grocery_app/pages/AdminScreens/InventoryManagement/controller.dart';

class InventoryView extends GetView<InventoryController> {
  const InventoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
        child: Padding(
            padding:  EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InventoryWidget(
                  title: 'Add',
                  icon: Icons.add,
                  color: LightAppColor.btnColor,
                  onPress: () {
                    Get.toNamed(AppRoutes.inventoryAddItem);
                  },
                ),
                InventoryWidget(
                  title: 'Edit',
                  icon: Icons.edit,
                  color: LightAppColor.btnColor,
                  onPress: () {
                    Get.toNamed(AppRoutes.inventoryEditItem);
                  },
                ),

                InventoryWidget(
                  title: 'Delete',
                  icon: Icons.delete_forever,
                  color: LightAppColor.btnColor,
                  onPress: () {},
                ),
                InventoryWidget(
                  title: 'Stock',
                  icon: Icons.inventory_outlined,
                  color: LightAppColor.btnColor,
                  onPress: () {},
                ),

              ],
            ),
        ),
      ),
          )),
    );
  }
}
