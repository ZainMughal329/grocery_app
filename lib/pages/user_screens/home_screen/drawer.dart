import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/colors/dark_app_color.dart';
import 'package:grocery_app/components/colors/light_app_colors.dart';
import 'package:grocery_app/components/reuseable/list_tile_widet.dart';
import 'package:grocery_app/components/reuseable/text_widget.dart';
import 'package:grocery_app/components/routes/name.dart';
import 'package:grocery_app/components/themes/dark_theme.dart';
import 'package:grocery_app/pages/user_screens/home_screen/controller.dart';

import '../../../components/reuseable/snackbar_widget.dart';
import '../../../components/services/session_controller.dart';

class BuildDrawer {
  static Drawer buildDrawer(BuildContext context) {
    var con = Get.put(HomeController());
    return Drawer(
      width: 300.w,
      backgroundColor
          : LightAppColor.bgColor,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                TextWidget(
                  title: 'Hey , ',
                  fontSize: 16.sp,
                ),
                Obx(
                  () => TextWidget(
                    title: con.state.username.value.toString(),
                    fontSize: 18.sp,
                    textColor: LightAppColor.btnColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            // height: 30.sp,
            padding: EdgeInsets.symmetric(vertical: 0.h),
            margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 0.h),
            width: MediaQuery.of(context).size.width * 0.8.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: LightAppColor.borderColor,
              ),
            ),
            child: ListTileWidget(
              iconData: Icons.location_pin,
              title: 'My location',
              onPress: () {},
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          ListTileWidget(
            iconData: Icons.category_outlined,
            title: 'Categories',
            onPress: () {
              Navigator.pop(context);

              Get.toNamed(AppRoutes.categoryScreen);
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
              Get.toNamed(AppRoutes.profileScreen);
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
              Get.toNamed(AppRoutes.faqsScreen);
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
              Get.toNamed(AppRoutes.helpCenterScreen);

            },
          ),
          SizedBox(
            height: 5.h,
          ),
          ListTileWidget(
            iconData: Icons.logout,
            title: 'Log Out',
            onPress: () async {
              Navigator.pop(context);

              final auth = FirebaseAuth.instance;
              await auth.signOut().then((value) {
                SessionController().userId = '';
                Snackbar.showSnackBar("Logout", "Successfully");
                Get.offNamed(AppRoutes.logInScreen);
              }).onError(
                (error, stackTrace) {
                  Snackbar.showSnackBar("Error", error.toString());
                },
              );
            },
          ),
          SizedBox(
            height: 10.h,
          ),
          Divider(),
          SizedBox(
            height: 10.h,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     TextWidget(title: 'Light Theme'),
          //     GetBuilder<DarkThemeChanger>(builder: (cont) {
          //       return Switch(
          //           activeColor: LightAppColor.btnColor,
          //           value: cont.getDarkTheme,
          //           onChanged: (bool value) {
          //             cont.setDarkTheme = value;
          //             print('value is : ' + cont.getDarkTheme.toString().trim());
          //
          //             // Get.theme.
          //           });
          //     }),
          //     TextWidget(title: 'Dark Theme'),
          //   ],
          // )
        ],
      ),
    );
  }
}
