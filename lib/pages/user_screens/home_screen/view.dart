import 'package:card_swiper/card_swiper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/reuseable/icon_widget.dart';
import 'package:grocery_app/components/reuseable/search_text_field.dart';
import 'package:grocery_app/components/reuseable/snackbar_widget.dart';
import 'package:grocery_app/components/reuseable/sub_category_container.dart';
import 'package:grocery_app/components/routes/name.dart';
import 'package:grocery_app/components/services/session_controller.dart';
import 'package:grocery_app/pages/session_sreens/login/controller.dart';
import 'package:grocery_app/pages/session_sreens/signup/controller.dart';
import 'package:grocery_app/pages/user_screens/home_screen/controller.dart';

import '../../../components/colors/light_app_colors.dart';
import '../../../components/constants/app_constants.dart';
import '../../../components/reuseable/on_sale_widget.dart';
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
                                activeSize: 13.0.sp),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 460.h,
                      color: Colors.grey.withOpacity(0.3),
                      child: Container(
                        height: 410.h,
                        padding: EdgeInsets.only(bottom: 30),
                        width: MediaQuery.of(context).size.width * 0.8.w,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextWidget(title: 'Trending Products'),
                                  TextButton(
                                    onPressed: () {},
                                    child: Container(
                                      height: 30.h,
                                      width: 70.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: LightAppColor.borderColor,
                                        ),
                                      ),
                                      child: Center(
                                        child: TextWidget(
                                          title: 'View all',
                                          textColor: Colors.orange,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.only(left: 5.w, right: 5.w),
                                    child: onSaleContainer(),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  List.generate(10, (index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          ExpansionTile(
                            backgroundColor: Colors.yellow.withOpacity(0.2),

                            iconColor: LightAppColor.btnColor,
                            subtitle: TextWidget(
                                title:
                                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry."),
                            leading: Container(
                              height: 160,
                              width: 110,
                              child: Image.asset('assets/pic1.jpeg' , fit: BoxFit.cover,),

                            ),
                            title: TextWidget(
                              title: 'Item : ' + index.toString(),
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 220.h, // Adjust the height as needed
                                  child: GridView.count(
                                    crossAxisCount: 3,
                                    // Number of columns in the grid
                                    children: List.generate(4, (index) {
                                      return subCategoryWidget();
                                    }),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
