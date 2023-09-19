import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/reuseable/icon_widget.dart';
import 'package:grocery_app/components/reuseable/search_text_field.dart';
import 'package:grocery_app/components/reuseable/snackbar_widget.dart';
import 'package:grocery_app/components/routes/name.dart';
import 'package:grocery_app/components/services/session_controller.dart';
import 'package:grocery_app/pages/session_sreens/login/controller.dart';
import 'package:grocery_app/pages/session_sreens/signup/controller.dart';
import 'package:grocery_app/pages/user_screens/home_screen/controller.dart';

import '../../../components/colors/light_app_colors.dart';
import '../../../components/constants/app_constants.dart';
import '../../../components/reuseable/round_button.dart';
import '../../../components/reuseable/text_form_field.dart';
import '../../../components/reuseable/text_widget.dart';
import 'drawer.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightAppColor.bgColor,
      key: _scaffoldKey,
      drawer: BuildDrawer.buildDrawer(context),

      // appBar: AppBar(
      //   title: TextWidget(
      //     title: 'Home Screen',
      //     fontSize: 18.sp,
      //   ),
      //   backgroundColor: LightAppColor.bgColor,
      //   elevation: 0,
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),

              decoration: BoxDecoration(
                color: Colors.transparent,
                boxShadow: [

                  BoxShadow(
                    color: Colors.grey,
                    offset: const Offset(
                      5.0,
                      5.0,
                    ),
                    blurRadius: 5.0,
                    spreadRadius: 1.0,
                  ), //BoxShadow
                  BoxShadow(
                    color: Colors.white,
                    offset: const Offset(0.0, 0.0),
                    blurRadius: 0.0,
                    spreadRadius: 0.0,
                  ),
                ],
              ),
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        _scaffoldKey.currentState!.openDrawer();
                      },
                      child: IconWidget(iconData: Icons.menu)),
                  SizedBox(width: 5.w),
                  SearchInputTextField(
                      contr: controller.state.searchController,
                      descrip: AppConstants.search,
                      textInputAction: TextInputAction.search,
                      keyboardType: TextInputType.text,
                      icon: Icons.search),
                  SizedBox(width: 5.w),
                  InkWell(
                      onTap: () {},
                      child:
                          IconWidget(iconData: Icons.shopping_cart_outlined)),
                ],
              ),
            ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
      // resizeToAvoidBottomInset: false,
    );
  }
}
