import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/reuseable/icon_widget.dart';
import 'package:grocery_app/components/reuseable/search_text_field.dart';
import 'package:grocery_app/components/reuseable/snackbar_widget.dart';
import 'package:grocery_app/components/reuseable/sub_category_container.dart';
import 'package:grocery_app/components/routes/name.dart';
import 'package:grocery_app/components/services/cart_controller_reuseable.dart';
import 'package:grocery_app/components/services/session_controller.dart';
import 'package:grocery_app/pages/session_sreens/login/controller.dart';
import 'package:grocery_app/pages/session_sreens/signup/controller.dart';
import 'package:grocery_app/pages/user_screens/details/controller.dart';
import 'package:grocery_app/pages/user_screens/home_screen/controller.dart';
import 'package:grocery_app/pages/user_screens/home_screen/widgets/all_o_sale_items.dart';

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
  final GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCartAnimation;
  var cartQuantity = 0;



  void listClick(GlobalKey widgetKey) async {
    await runAddToCartAnimation(widgetKey);
    await cartKey.currentState!.runCartAnimation((++cartQuantity).toString());
  }

  @override
  Widget build(BuildContext context) {
    final con = Get.put(HomeController());
    Get.put(DetailsController());
    final cartCon = Get.find<CartControllerReuseAble>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: LightAppColor.bgColor,
      key: _scaffoldKey,
      drawer: BuildDrawer.buildDrawer(context),
      body: AddToCartAnimation(
        cartKey: cartKey,
        height: 30,
        width: 30,
        opacity: 0.85,
        dragAnimation: DragToCartAnimationOptions(
          rotation: true,
        ),
        jumpAnimation: JumpAnimationOptions(),
        createAddToCartAnimation: (runAddToCartAnimation) {
          this.runAddToCartAnimation = runAddToCartAnimation;
        },
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
            child: CustomScrollView(
              // shrinkWrap: true,
              slivers: <Widget>[
                SliverAppBar(
                  elevation: 2,
                  forceElevated: true,
                  backgroundColor: LightAppColor.bgColor,
                  pinned: true,
                  leading: IconButton(
                    onPressed: () {
                      _scaffoldKey.currentState!.openDrawer();
                    },
                    icon: IconWidget(iconData: Icons.menu),
                  ),
                  actions: <Widget>[
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.cartScreen);
                      },
                      child: AddToCartIcon(
                        key: cartKey,
                        icon: IconWidget(iconData: Icons.shopping_cart),
                        badgeOptions: const BadgeOptions(
                          active: false,
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ),
                  ],
                  title: Padding(
                    padding: EdgeInsets.only(bottom: 5.h),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.searchScreen);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 0),
                        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0),
                        width: MediaQuery.of(context).size.width * 0.80.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                            color: LightAppColor.bgColor,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: LightAppColor.borderColor,
                            )),
                        child: Padding(
                          padding: EdgeInsets.only(left:8.w),
                          child: Row(
                            children: [
                              IconWidget(iconData: Icons.search , fontSize: 20.sp,),
                              SizedBox(
                                width: 5.w,
                              ),
                              TextWidget(title: 'What are you looking for?' , fontSize: 12.sp,)
                            ],
                          ),
                        ),
                      )
                    ),
                  ),
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
                          margin: EdgeInsets.only(
                              left: 10.w, top: 10.h, bottom: 10.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                          ),
                          child: FutureBuilder(
                            future: con.getAndShowALlItemsData(),
                            builder: (BuildContext context, snapshot) {
                              try {
                                if (snapshot.hasData) {
                                  return snapshot.data!.length != 0
                                      ? Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                TextWidget(title: 'On Sale Products'),
                                                TextButton(
                                                  onPressed: () {
                                                    Get.to( ()=> SeeAllOnSaleItems());
                                                  },
                                                  child: Container(
                                                    height: 30.h,
                                                    width: 70.w,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(5),
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
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                itemCount:
                                                    snapshot.data!.length,
                                                itemBuilder: (context, index) {
                                                  if (snapshot.data![index]
                                                          .discount ==
                                                      0) {
                                                    return Container();
                                                  } else {
                                                    if (index <=10){
                                                    return Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 5.w,
                                                          right: 5.w),
                                                      child: onSaleContainer(
                                                        itemName: snapshot
                                                            .data![index].title,
                                                        itemQty: snapshot
                                                            .data![index]
                                                            .priceQty,
                                                        itemPrice: snapshot
                                                            .data![index].price,
                                                        discountedPrice: cartCon
                                                            .calculateDiscountedPrice(
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .price,
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .discount),
                                                        itemImg: snapshot
                                                            .data![index]
                                                            .imageUrl,
                                                        discount: snapshot
                                                            .data![index]
                                                            .discount!
                                                            .toInt(),
                                                        userName: cartCon
                                                            .username.value,
                                                        itemId: snapshot
                                                            .data![index].itemId
                                                            .toString(),
                                                        index: index,
                                                        onClick: listClick,
                                                        cat: snapshot
                                                            .data![index].category,
                                                        subCat: snapshot
                                                            .data![index].subCategory,
                                                        dis: snapshot
                                                            .data![index].discount!
                                                            .toInt(), stock: snapshot
                                                          .data![index].stock,
                                                      ),
                                                    );
                                                  }}
                                                },
                                              ),
                                            ),
                                        ],
                                      )
                                      : Container();
                                } else if (snapshot.hasError) {
                                  return Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Center(
                                          child: CircularProgressIndicator(
                                        color: LightAppColor.btnColor,
                                      )),
                                    ],
                                  );
                                } else {
                                  return SizedBox();
                                }
                              } catch (e) {
                                return Text(
                                  'data : ' + e.toString(),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    List.generate(controller.category.length, (index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: [
                            ExpansionTile(
                              backgroundColor: Colors.yellow.withOpacity(0.2),
                              iconColor: LightAppColor.btnColor,
                              subtitle: TextWidget(
                                title: controller.category[index].subTitle,
                                fontSize: 10.sp,
                                textColor: Colors.grey,
                              ),
                              leading: Container(
                                height: 160,
                                width: 110,
                                child: Image.asset(
                                  // 'assets/pic'+index.toString()+'.jpeg',
                                  controller.imagesList[index].toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: TextWidget(
                                title: controller.category[index].category,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 220.h,
                                    // Adjust the height as needed
                                    child: GridView.count(
                                      crossAxisCount: 3,
                                      // Number of columns in the grid
                                      children: List.generate(5, (ind) {
                                        return subCategoryWidget(
                                          title: controller
                                              .category[index].subCategory[ind],
                                          category: controller
                                              .category[index].category,
                                          subCategory: controller
                                              .category[index].subCategory[ind],
                                        );
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
      ),
    );
  }
}

class CategoryItem {
  final String category;
  final String subTitle;
  final List<String> subCategory;

  CategoryItem({
    required this.category,
    required this.subTitle,
    required this.subCategory,
  });
}
