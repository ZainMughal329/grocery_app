import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grocery_app/components/reuseable/icon_widget.dart';
import 'package:grocery_app/components/reuseable/text_widget.dart';
import 'package:grocery_app/components/services/cart_open.dart';

import '../../pages/user_screens/details/details.dart';


class onSaleContainer extends StatefulWidget {
  String itemName;
  String itemQty;
  int itemPrice;
  int discountedPrice;
  String itemImg;
  int discount;
  String userName;

  onSaleContainer(
      {super.key,
      required this.itemName,
      required this.itemQty,
      required this.itemPrice,
      required this.discountedPrice,
      required this.itemImg,
      required this.discount
      ,required this.userName,
      });

  @override
  State<onSaleContainer> createState() => _onSaleContainerState();
}

class _onSaleContainerState extends State<onSaleContainer> {
  int count = 1;
  bool isTrue = false;
  StorePrefrences sp = StorePrefrences();

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
                    category: widget.itemName,
                    itemImg: widget.itemImg,
                    itemQty: widget.itemQty,
                    price: widget.itemPrice,
                        userName: widget.userName,
                  ),
                );
              },
              child: Center(
                child: Container(
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
              color: Colors.green,
              child: isTrue == true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconWidget(iconData: Icons.remove),
                        TextWidget(title: count.toString()),
                        IconWidget(iconData: Icons.add),
                      ],
                    )
                  : GestureDetector(

                      onTap: () async {
                        StorePrefrences sp =StorePrefrences();
                        setState(() {
                          isTrue = true;
                        });
                        await sp.setIsFirstOpen(true);
                        print('object :' + sp.getIsFirstOpen().toString());
                      },
                      child: Center(
                        child: TextWidget(
                          title: 'Add to cart',
                          textColor: Colors.white,
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
