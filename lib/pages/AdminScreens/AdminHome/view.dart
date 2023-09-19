import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/colors/light_app_colors.dart';
import 'package:grocery_app/components/constants/app_constants.dart';
import 'package:grocery_app/pages/AdminScreens/AdminHome/controller.dart';
import 'package:grocery_app/pages/AdminScreens/InventoryManagement/view.dart';
import 'package:grocery_app/pages/AdminScreens/dashboard/view.dart';
import 'package:grocery_app/pages/AdminScreens/orders/view.dart';

class AdminHomeView extends GetView<AdminHomeController> {
  const AdminHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(title: Text("Administration"),
            backgroundColor: LightAppColor.btnColor.shade400,
            bottom: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white.withOpacity(0.7), // You can adjust the opacity or color as needed
              indicatorColor: Colors.greenAccent,
            tabs: [
            Tab(text: 'DASHBOARD'),
        Tab(text: 'ORDERS'),
        Tab(text: 'INVENTORY'),
              // Tab(text: 'DISCOUNTS'),
        ],
      )
          ,),
        body: TabBarView(
          children: [
            DashBoardView(),
            OrdersView(),
            InventoryView(),
            // Center(child: Text('Chats Content')),   // content of CHATS tab
            // Center(child: Text('Status Content')),  // content of STATUS tab
            // Center(child: Text('Calls Content')),
            // Center(child: Text('Orders Content')),
          ],
        ),
      ),
    );
  }
}
