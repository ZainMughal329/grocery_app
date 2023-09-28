import 'dart:ffi';

import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grocery_app/pages/user_screens/details/controller.dart';

import '../../../components/colors/light_app_colors.dart';
import '../../../components/reuseable/icon_widget.dart';
import '../../../components/reuseable/snackbar_widget.dart';
import '../../../components/reuseable/text_widget.dart';
import '../../../components/routes/name.dart';
import '../../../components/services/cart_controller_reuseable.dart';

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
  bool? isTrue;

  DetailsScreen({
    super.key,
    required this.title,
    required this.itemImg,
    required this.price,
    required this.itemQty,
    required this.userName,
    required this.itemId,
    required this.category,
    required this.subCategory,
    required this.discount,
    this.isTrue,
  });

  final con = Get.put(DetailsController());

  final cartCon = Get.find<CartControllerReuseAble>();

  final GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();

  late Function(GlobalKey) runAddToCartAnimation;

  var cartQuantity = 0;

  final GlobalKey widgetKey = GlobalKey();

  // final int index;
  void listClick(GlobalKey widgetKey) async {
    await runAddToCartAnimation(widgetKey);
    await cartKey.currentState!.runCartAnimation((++cartQuantity).toString());
  }

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
                        Get.toNamed(AppRoutes.homeScreen);
                      },
                      icon: IconWidget(
                        iconData: Icons.arrow_back,
                      ),
                    ),
                    actions: [
                      SizedBox(
                        width: 5.w,
                      ),
                      IconButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.searchScreen);
                        },
                        icon: IconWidget(
                          iconData: Icons.search,
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
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
                                key: widgetKey,
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
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: InkWell(
                                              onTap: () {
                                                Get.snackbar(
                                                  'Please wait',
                                                  'Loading...',
                                                  backgroundColor: LightAppColor
                                                      .snackBarbgColor,
                                                  // dark grey background
                                                  colorText:
                                                      LightAppColor.textColor,
                                                  titleText: Text(
                                                    'Please wait',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: LightAppColor
                                                          .btnColor, // for a splash of color
                                                    ),
                                                  ),
                                                  messageText: Text(
                                                    'Loading...',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: LightAppColor
                                                          .textColor,
                                                    ),
                                                  ),
                                                  icon: Icon(
                                                    Icons.info_outline,
                                                    color:
                                                        LightAppColor.iconColor,
                                                  ),
                                                  snackPosition:
                                                      SnackPosition.TOP,
                                                  borderRadius: 8,
                                                  margin: EdgeInsets.all(10),
                                                  forwardAnimationCurve:
                                                      Curves.easeOutExpo,
                                                  reverseAnimationCurve:
                                                      Curves.easeInOut,
                                                );

                                                con.shareProduct(title,
                                                    price.toString(), itemImg);
                                              },
                                              child: Icon(
                                                Icons.share,
                                                color: Colors.orange,
                                              )),
                                        ),
                                        // IconButton(onPressed: () {}, icon: AnimatedIcon(icon: AnimatedIcons., progress: progress)),
                                        Obx(
                                          () => con.itemIdsForWishList
                                                  .contains(itemId)
                                              ? GestureDetector(
                                                  onTap: () {
                                                    con.deleteDataFromWishList(
                                                        itemId);
                                                    con.fetchWishListData();
                                                  },
                                                  child: IconWidget(
                                                    iconData: Icons.favorite,
                                                    iconColor: Colors.orange,
                                                  ),
                                                )
                                              : GestureDetector(
                                                  onTap: () {
                                                    con.addDataToFirebaseInWishList(
                                                        userName,
                                                        price,
                                                        title,
                                                        // DateTime.now(),
                                                        1,
                                                        itemId,
                                                        itemImg,
                                                        category,
                                                        subCategory,
                                                        discount);
                                                    con.fetchWishListData();
                                                  },
                                                  child: IconWidget(
                                                    iconData:
                                                        Icons.favorite_outline,
                                                    iconColor: Colors.orange,
                                                  ),
                                                ),
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
              Align(
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
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.orange,
                    ),
                    padding: EdgeInsets.all(16.0),
                    child: Obx(
                      () => con.itemIds.contains(itemId)
                          ? GestureDetector(
                              onTap: () {
                                Snackbar.showSnackBar(
                                    'Note', 'Already in the cart');
                              },
                              child: Center(
                                child: TextWidget(
                                  title: 'In Cart',
                                  textColor: Colors.white,
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                listClick(widgetKey);
                                con.fetchData();
                                print(con.itemIds.contains(itemId).toString());
                                print(con.isInCart(itemId).toString());
                                // con.setIsTrue(true);
                                DateTime currentDate = DateTime.now();
                                DateTime dateTime = DateTime(currentDate.year,
                                    currentDate.month, currentDate.day);

                                con.addDataToFirebase(
                                    userName,
                                    price,
                                    title,
                                    dateTime,
                                    1,
                                    itemId,
                                    itemImg,
                                    category,
                                    subCategory,
                                    discount);
                                cartCon.addTotalPrice(
                                  con.calculateDiscountedPrice(price, discount),
                                );

                                // cartCon.isTrue.value == true;
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
