import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grocery_app/pages/user_screens/details/controller.dart';

import '../../../components/colors/light_app_colors.dart';
import '../../../components/reuseable/icon_widget.dart';
import '../../../components/reuseable/text_widget.dart';
import '../../../components/routes/name.dart';

class DetailsScreen extends StatelessWidget {
  String title;
  String itemImg;
  int price;
  String itemQty;
  String userName;
  String itemId;
  String category;
  String subCategory;
  int discount;


  DetailsScreen(
      {super.key,
      required this.title,
      required this.itemImg,
      required this.price,
      required this.itemQty,
      required this.userName,
        required this.itemId,
        required this.category,
        required this.subCategory,
        required this.discount,
      });

  int count = 1;

  bool isTrue = false;

  final con = Get.put(DetailsController());

  Widget _buildBulletListItem(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 35.sp),
      child: Row(
        children: [
          IconWidget(
            iconData: Icons.fiber_manual_record,
            iconColor: Colors.black,
            fontSize: 10.sp,
          ),
          SizedBox(
            width: 10.w,
          ),
          TextWidget(
            title: text,
            fontWeight: FontWeight.bold,
            fontSize: 17.sp,
            fontStyle: FontStyle.italic,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  elevation: 2,
                  forceElevated: true,
                  pinned: true,
                  title: TextWidget(
                    title: title,
                    fontSize: 18.sp,
                  ),
                  leading: IconButton(
                    onPressed: () {
                      Get.offAndToNamed(AppRoutes.homeScreen);
                    },
                    icon: IconWidget(
                      iconData: Icons.arrow_back,
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: IconWidget(
                        iconData: Icons.share,
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: IconWidget(
                        iconData: Icons.search,
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: IconWidget(
                        iconData: Icons.shopping_cart,
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                  ],
                  backgroundColor: LightAppColor.bgColor,
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 20.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              title: title,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            Container(
                              height: 200.h,
                              width: double.infinity,
                              child: Image.network(itemImg),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextWidget(
                                    title: "Rs " + price.toString(),
                                    fontWeight: FontWeight.bold,
                                    textColor: Colors.red,
                                    fontSize: 17.sp,
                                  ),
                                  Row(
                                    children: [
                                      IconWidget(
                                        iconData: Icons.favorite_outline,
                                        iconColor: Colors.orange,
                                      ),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      TextWidget(
                                        title: itemQty,
                                        textColor: Colors.grey,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Column(
                              children: <Widget>[
                                _buildBulletListItem('100% pure'),
                                SizedBox(
                                  height: 7.h,
                                ),
                                _buildBulletListItem('Standard Quality'),
                                SizedBox(
                                  height: 7.h,
                                ),
                                _buildBulletListItem('Good for use'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 500,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
      Obx(() => Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 70.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey),
                  ),
                ),
                child: Container(
                  height: 50.h,
                  width: 200.w,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.green,

                  ),
                  padding: EdgeInsets.all(16.0),
                  child: con.itemIds.contains(itemId) && con.isInCart(itemId)
                      ? Center(
                    child: TextWidget(
                      title: 'Already in cart',
                      textColor: Colors.white,
                    ),
                  )
                      : GestureDetector(
                    onTap: () {
                      print(con.itemIds.contains(itemId).toString());
                      print(con.isInCart(itemId).toString());
                      // con.setIsTrue(true);
                      DateTime currentDate = DateTime.now();
                      DateTime dateTime = DateTime(currentDate.year,
                          currentDate.month, currentDate.day);
                      con.addDataToFirebase(userName,
                          price, title, dateTime, count , itemId , itemImg,category,subCategory,discount);
                    },
                    child: Center(
                      child: TextWidget(
                        title: 'Add to cart',
                        textColor: Colors.white,
                      ),
                    ),
                  ),

                ),
              ),
            ),),
          ],
        ),
      ),
    );
  }
}
