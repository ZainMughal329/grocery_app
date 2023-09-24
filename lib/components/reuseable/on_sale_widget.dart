import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grocery_app/components/reuseable/icon_widget.dart';
import 'package:grocery_app/components/reuseable/snackbar_widget.dart';
import 'package:grocery_app/components/reuseable/text_widget.dart';
import 'package:grocery_app/components/services/cart_controller_reuseable.dart';
import 'package:grocery_app/components/services/cart_open.dart';
import 'package:grocery_app/pages/user_screens/details/controller.dart';

import '../../pages/user_screens/details/details.dart';

class onSaleContainer extends StatefulWidget {
  String itemName;
  String itemQty;
  int itemPrice;
  int discountedPrice;
  String itemImg;
  int discount;
  String userName;
  String itemId;
  String cat;
  String subCat;
  int dis;

  final GlobalKey widgetKey = GlobalKey();
  final int index;
  final void Function(GlobalKey) onClick;

  onSaleContainer({
    super.key,
    required this.itemName,
    required this.itemQty,
    required this.itemPrice,
    required this.discountedPrice,
    required this.itemImg,
    required this.discount,
    required this.userName,
    required this.itemId,
    required this.index,
    required this.onClick,
    required this.cat,
    required this.subCat,
    required this.dis,
  });

  @override
  State<onSaleContainer> createState() => _onSaleContainerState();
}

class _onSaleContainerState extends State<onSaleContainer> {
  int count = 1;
  bool isTrue = false;
  StorePrefrences sp = StorePrefrences();
  final detailsCon = Get.put(DetailsController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      width: 220.w,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
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
              onTap: () {
                Get.to(
                  () => DetailsScreen(
                    title: widget.itemName,
                    itemImg: widget.itemImg,
                    itemQty: widget.itemQty,
                    price: widget.itemPrice,
                    userName: widget.userName,
                    itemId: widget.itemId, category: widget.cat, subCategory: widget.subCat, discount: widget.dis,
                  ),
                );
              },
              child: Center(
                child: Container(
                  key: widget.widgetKey,

                  height: 130.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                      // border: Border.all(color: Colors.grey),
                      ),
                  child: widget.itemImg == ''
                      ? IconWidget(iconData: Icons.shopping_cart_outlined)
                      : Image.network(widget.itemImg),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            TextWidget(
              title: widget.itemName,
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
            ),
            TextWidget(
              title: widget.itemQty,
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
                  color: Colors.red, borderRadius: BorderRadius.circular(20)),
              child: Center(
                  child: TextWidget(
                title: widget.discount.toString() + '% OFF',
                fontWeight: FontWeight.bold,
                textColor: Colors.white,
                fontSize: 12.sp,
              )),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                TextWidget(
                  title: 'Rs: ' + widget.discountedPrice.toString(),
                  fontWeight: FontWeight.bold,
                  textColor: Colors.orange,
                  fontSize: 18.sp,
                ),
                SizedBox(
                  width: 3.w,
                ),
                TextWidget(
                  title: 'Rs: ' + widget.itemPrice.toString(),
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Colors.black,
                ),
              ],
            ),
            SizedBox(
              height: 50.h,
            ),
            Container(
              height: 50.h,
              width: 200.w,
              decoration: BoxDecoration(
                color: Colors.orange,
               borderRadius: BorderRadius.circular(10),

              ),
              child: Obx(
                () => isTrue == true || detailsCon.itemIds.contains(widget.itemId)
                    ? GestureDetector(
                  onTap: (){
                    Snackbar.showSnackBar('Note', 'Already in the cart');
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
                          widget.onClick(widget.widgetKey);
                          detailsCon.fetchData();
                          final CartControllerReuseAble cartController =
                              Get.find<CartControllerReuseAble>();
                          cartController.addToCart();
                          print(detailsCon.itemIds
                              .contains(widget.itemId)
                              .toString());
                          setState(() {
                            isTrue = true;
                          });
                          DateTime currentDate = DateTime.now();
                          DateTime dateTime = DateTime(currentDate.year,
                              currentDate.month, currentDate.day);
                          detailsCon.addDataToFirebase(
                            widget.userName,
                            widget.itemPrice,
                            widget.itemName,
                            dateTime,
                            count,
                            widget.itemId,
                            widget.itemImg,
                              widget.cat,
                              widget.subCat,
                              widget.dis
                          );
                          cartController.addTotalPrice(widget.discountedPrice);
                          setState(() {
                            isTrue = true;
                          });
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
          ],
        ),
      ),
    );
  }
}
