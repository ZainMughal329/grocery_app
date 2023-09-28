import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/colors/light_app_colors.dart';
import 'package:grocery_app/components/reuseable/text_widget.dart';
import 'package:grocery_app/components/services/cart_controller_reuseable.dart';
import 'package:grocery_app/pages/user_screens/home_screen/controller.dart';

import '../../../../components/reuseable/icon_widget.dart';
import '../../../../components/reuseable/on_sale_widget.dart';
import '../../details/details.dart';

class SeeAllOnSaleItems extends GetView<HomeController> {
  SeeAllOnSaleItems({super.key});

  final cartCon = Get.find<CartControllerReuseAble>();
  Widget _buildOnSaleCard(
      String itemName,
      String itemQty,
      int itemPrice,
      int discountedPrice,
      String itemImg,
      int discount,
      String itemId,
      String cat,
      String subCat,
      ) {
    return GestureDetector(
      onTap: () {
        Get.to(
              () => DetailsScreen(
              title: itemName,
              itemImg: itemImg,
              price: itemPrice,
              itemQty: itemQty,
              userName: cartCon.username.value,
              itemId: itemId,
              category: cat,
              subCategory: subCat,
              discount: discount),
        );
      },
      child: Container(
        height: 250.h,
        width: 230.w,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey.withOpacity(0.5),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 1),
              )
            ]),
        child: Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {},
                child: Center(
                  child: Container(
                    // key: widget.widgetKey,
                    height: 130.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      // border: Border.all(color: Colors.grey),
                    ),
                    child: itemImg == ''
                        ? IconWidget(iconData: Icons.shopping_cart_outlined)
                        : Image.network(itemImg),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              TextWidget(
                title: itemName,
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
              ),
              TextWidget(
                title: itemQty,
                fontSize: 13.sp,
                textColor: Colors.grey,
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                height: 25.h,
                width: 55.w,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: TextWidget(
                      title: discount.toString() + '% OFF',
                      fontWeight: FontWeight.bold,
                      textColor: Colors.white,
                      fontSize: 12.sp,
                    )),
              ),
              SizedBox(
                height: 0.h,
              ),
              Row(
                children: [
                  TextWidget(
                    title: 'Rs: ' + discountedPrice.toString(),
                    fontWeight: FontWeight.bold,
                    textColor: Colors.orange,
                    fontSize: 18.sp,
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  TextWidget(
                    title: 'Rs: ' + itemPrice.toString(),
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Colors.black,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          title: 'On-Sale Items',
          fontSize: 18.sp,

        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
        icon: IconWidget(
          iconData: Icons.arrow_back,
        ),
        ),

        backgroundColor: LightAppColor.bgColor,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(top: 10.h, right: 3.w, left: 5.w),
        child: FutureBuilder(
          future: controller.getAndShowALlItemsData(),
          builder: (BuildContext context, snapshot) {
            try {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: CircularProgressIndicator());
              }
              var len = snapshot.data!.length;

              List<Widget> cardRows = [];
              for (int i = 0; i < snapshot.data!.length; i += 2) {
                if (i + 1 < snapshot.data!.length) {
                  cardRows.add(Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: snapshot.data![i].discount != 0
                              ? Container(
                                  height: 280.h,
                                  width: 180.w,
                                  child: _buildOnSaleCard(
                                    snapshot.data![i].title,
                                    snapshot.data![i].priceQty,
                                    snapshot.data![i].price,
                                    cartCon.calculateDiscountedPrice(snapshot.data![i].price, snapshot.data![i].discount),
                                    snapshot.data![i].imageUrl,
                                    snapshot.data![i].discount!.toInt(),
                                    snapshot.data![i].itemId.toString(),
                                    snapshot.data![i].category,
                                    snapshot.data![i].subCategory,
                                  ),
                                )
                              : Container(),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: snapshot.data![i].discount != 0
                              ? Container(
                                  height: 280.h,
                                  width: 180.w,
                                  child: _buildOnSaleCard(
                                    snapshot.data![i + 1].title,
                                    snapshot.data![i + 1].priceQty,
                                    snapshot.data![i + 1].price,
                                    cartCon.calculateDiscountedPrice(snapshot.data![i+1].price, snapshot.data![i+1].discount),
                                    snapshot.data![i + 1].imageUrl,
                                    snapshot.data![i + 1].discount!.toInt(),
                                    snapshot.data![i + 1].itemId.toString(),
                                    snapshot.data![i + 1].category,
                                    snapshot.data![i + 1].subCategory,
                                  ),
                                )
                              : Container(),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                    ],
                  ));
                } else {
                  cardRows.add(Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: snapshot.data![i].discount != 0
                              ? Container(
                                  height: 280.h,
                                  width: 180.w,
                                  child: _buildOnSaleCard(
                                    snapshot.data![i].title,
                                    snapshot.data![i].priceQty,
                                    snapshot.data![i].price,
                                    cartCon.calculateDiscountedPrice(snapshot.data![i].price, snapshot.data![i].discount),
                                    snapshot.data![i].imageUrl,
                                    snapshot.data![i].discount!.toInt(),
                                    snapshot.data![i].itemId.toString(),
                                    snapshot.data![i].category,
                                    snapshot.data![i].subCategory,
                                  ),
                                )
                              : Container(),
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ));
                }
              }
              return snapshot.data!.length != 0
                  ? ListView(
                      children: cardRows,
                    )
                  : Center(
                      child: Text('No tours added now.'),
                    );
            } catch (e) {
              print('Exception is : ' + e.toString());
              return Text('data : ' + e.toString());
            }
          },
        ),
      ),

    );
  }
}
