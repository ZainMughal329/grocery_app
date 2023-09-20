import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/components/colors/light_app_colors.dart';
import 'package:grocery_app/components/constants/app_constants.dart';
import 'package:grocery_app/components/reuseable/text_widget.dart';
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
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                title: TextWidget(
                  title: 'Administration',
                  textColor: LightAppColor.btnColor,
                  fontSize: 17.sp,
                ),
                backgroundColor: LightAppColor.btnTextColor,
                pinned: true, // to ensure the AppBar remains visible at the top
                floating: true, // to show/hide AppBar when scrolling up/down
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(50.0), // Set this appropriately
                  child: TabBar(
                    labelColor: LightAppColor.btnColor,
                    unselectedLabelColor: LightAppColor.btnColor.withOpacity(0.5),
                    indicatorColor: LightAppColor.btnColor,
                    labelStyle: GoogleFonts.poppins(
                      fontSize: 14.sp,
                    ),
                    tabs: [
                      Tab(text: 'DASHBOARD'),
                      Tab(text: 'ORDERS'),
                      Tab(text: 'INVENTORY'),
                    ],
                  ),
                ),
              ),
              SliverFillRemaining(
                child: TabBarView(
                  children: [
                    DashBoardView(),
                    OrdersView(),
                    InventoryView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// class AdminHomeView extends GetView<AdminHomeController> {
//   const AdminHomeView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           title: TextWidget(
//             title: 'Administration',
//             textColor: LightAppColor.btnColor,
//             fontSize: 17.sp,
//           ),
//           backgroundColor: LightAppColor.btnTextColor,
//           bottom: TabBar(
//             labelColor: LightAppColor.btnColor,
//             unselectedLabelColor: LightAppColor.btnColor.withOpacity(0.5),
//             indicatorColor: LightAppColor.btnColor,
//             labelStyle: GoogleFonts.poppins(
//               fontSize: 14.sp,
//             ),
//             tabs: [
//               Tab(text: 'DASHBOARD'),
//               Tab(text: 'ORDERS'),
//               Tab(text: 'INVENTORY'),
//               // Tab(text: 'DISCOUNTS'),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             DashBoardView(),
//             OrdersView(),
//             InventoryView(),
//             // Center(child: Text('Chats Content')),   // content of CHATS tab
//             // Center(child: Text('Status Content')),  // content of STATUS tab
//             // Center(child: Text('Calls Content')),
//             // Center(child: Text('Orders Content')),
//           ],
//         ),
//       ),
//     );
//   }
// }
