import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/colors/light_app_colors.dart';
import 'package:grocery_app/components/reuseable/inventory_widget.dart';
import 'package:grocery_app/components/routes/name.dart';
import 'package:grocery_app/pages/AdminScreens/orders/OrderHome/controller.dart';

class OrderHomeView extends GetView<OrderHomeController> {
  OrderHomeView({Key? key}) : super(key: key);
  final controller = Get.put<OrderHomeController>(OrderHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InventoryWidget(
                  title: 'All Orders',
                  icon: Icons.done_all,
                  color: LightAppColor.btnColor,
                  onPress: () {
                    Get.toNamed(AppRoutes.allOrders);
                  },
                ),
                InventoryWidget(
                  title: 'Pending',
                  icon: Icons.access_time_outlined,
                  color: LightAppColor.btnColor,
                  onPress: () {
                    Get.toNamed(AppRoutes.orderPending);
                  },
                ),
                InventoryWidget(
                  title: 'Shipped',
                  icon: Icons.local_shipping_outlined,
                  color: LightAppColor.btnColor,
                  onPress: () {
                    Get.toNamed(AppRoutes.orderShipped);
                  },
                ),
                InventoryWidget(
                  title: 'Delivered',
                  icon: Icons.pending_actions_outlined,
                  color: LightAppColor.btnColor,
                  onPress: () {
                    Get.toNamed(AppRoutes.orderDelivered);
                  },
                ),
                InventoryWidget(
                  title: 'Cancelled',
                  icon: Icons.cancel_outlined,
                  color: LightAppColor.btnColor,
                  onPress: () {
                    Get.toNamed(AppRoutes.orderCanceled);
                  },
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
