import 'package:card_swiper/card_swiper.dart';
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
    final con = Get.put(HomeController());

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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
          child: CustomScrollView(
            // shrinkWrap: true,
            slivers: <Widget>[
              SliverAppBar(
                elevation: 6,
                backgroundColor: LightAppColor.bgColor,
                pinned: true,
                leading: IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                  icon: IconWidget(iconData: Icons.menu),
                ),
                actions: <Widget>[
                  IconButton(
                    icon: IconWidget(
                      iconData: Icons.shopping_cart_outlined,
                    ),
                    onPressed: () {
                      // Handle cart button press
                    },
                  ),
                ],
                title: SearchInputTextField(
                    contr: controller.state.searchController,
                    descrip: AppConstants.search,
                    textInputAction: TextInputAction.search,
                    keyboardType: TextInputType.text,
                    icon: Icons.search),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.33.h,
                      color: Colors.grey.withOpacity(0.3),
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.28.h,
                        child: Swiper(
                          itemBuilder: (BuildContext context, int index) {
                            return Image.asset(
                              con.imagesList[index],
                              fit: BoxFit.cover,
                              height: 188.h,
                              width: 288.w,
                            );
                          },
                          autoplay: true,
                          itemCount: con.imagesList.length,
                          viewportFraction: 0.8,
                          scale: 0.9,
                          pagination: SwiperPagination(
                              alignment: Alignment.bottomCenter,
                              builder: DotSwiperPaginationBuilder(
                                  color: Colors.grey,
                                  activeColor: Colors.orange,
                                  activeSize: 13.0.sp)),
                        ),
                      ),
                    ),
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
