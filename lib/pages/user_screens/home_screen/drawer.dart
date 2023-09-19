import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/colors/light_app_colors.dart';
import 'package:grocery_app/components/reuseable/list_tile_widet.dart';
import 'package:grocery_app/components/reuseable/text_widget.dart';
import 'package:grocery_app/pages/user_screens/home_screen/controller.dart';

class BuildDrawer {
  static Drawer buildDrawer(BuildContext context) {
    var con = Get.put(HomeController());
    return Drawer(
      width: 300.w,
      backgroundColor: LightAppColor.bgColor,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextWidget(
              title: 'Hey , Guest User',
              fontSize: 16.sp,
            ),
          ),
          Container(
            height: 30.sp,
            margin: EdgeInsets.symmetric(horizontal: 5.w),
            width: MediaQuery.of(context).size.width * 0.8.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: LightAppColor.borderColor,
                )),
          ),
          SizedBox(
            height: 10.h,
          ),
          ListTileWidget(
            iconData: Icons.category_outlined,
            title: 'Categories',
            onPress: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(
            height: 5.h,
          ),
          ListTileWidget(
            iconData: Icons.shopping_cart_outlined,
            title: 'My Cart',
            onPress: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(
            height: 5.h,
          ),
          ListTileWidget(
            iconData: Icons.person_pin_circle_outlined,
            title: 'My Profile',
            onPress: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(
            height: 5.h,
          ),
          ListTileWidget(
            iconData: Icons.description_outlined,
            title: 'My Orders',
            onPress: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(
            height: 5.h,
          ),
          ListTileWidget(
            iconData: Icons.error_outline_outlined,
            title: 'FAQs',
            onPress: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(
            height: 5.h,
          ),
          ListTileWidget(
            iconData: Icons.favorite_outline,
            title: 'Wish List',
            onPress: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(
            height: 5.h,
          ),
          ListTileWidget(
            iconData: Icons.help_outline_outlined,
            title: 'Help Center',
            onPress: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(
            height: 5.h,
          ),
          ListTileWidget(
            iconData: Icons.logout,
            title: 'Log Out',
            onPress: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
