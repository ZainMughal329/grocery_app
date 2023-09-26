import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/colors/light_app_colors.dart';
import 'package:grocery_app/components/reuseable/icon_widget.dart';
import 'package:grocery_app/components/reuseable/text_widget.dart';
import 'package:grocery_app/components/routes/name.dart';
import 'package:grocery_app/pages/user_screens/faqs/controller.dart';
import 'package:grocery_app/pages/user_screens/wishList_screen/controller.dart';

import '../details/details.dart';

class WishListScreen extends GetView<WishListController> {
  Widget _buildlistTile(BuildContext context, String img, String title,
      String category, String subCategory, int price, int discount) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: BoxDecoration(
                border: Border(
                    right: BorderSide(width: 1.0, color: Colors.grey[200]!))),
            child: Image.network(
              img,
              fit: BoxFit.cover,
              width: 50,
              height: 50,
            ), // assuming you store image URLs in firestore
          ),
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 5.0),
              Text(
                category,
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 5.0),
              Text(
                subCategory,
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 5.0),
              Row(
                children: [
                  Text(
                    'RS${price}',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        decoration: discount != 0 && discount > 0
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ),
                  discount != 0 && discount > 0
                      ? Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'RS ' +
                                controller
                                    .calculateDiscountedPrice(price, discount)
                                    .toString(),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        )
                      : Container(),
                  if (discount != 0 && discount > 0)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        '${discount}% OFF',
                        style: TextStyle(fontSize: 12, color: Colors.red),
                      ),
                    ),
                ],
              ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Container(),
              SizedBox(
                height: 10.h,
              ),
              IconWidget(iconData: Icons.arrow_forward_ios_rounded),
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
          title: 'WishList',
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
        backgroundColor: LightAppColor.bgColor,
      ),
      body: SafeArea(
        child: Container(
            child: FutureBuilder(
          future: controller.getAndShowALlFavouriteItemsData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!.length != 0
                  ? ListView.builder(
                      // shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 5.h),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(
                                () => DetailsScreen(
                                    title: snapshot.data![index].itemName,
                                    itemImg: snapshot.data![index].itemImg,
                                    price: snapshot.data![index].totalPrice,
                                    itemQty: snapshot.data![index].itemQty
                                        .toString(),
                                    userName: controller.state.username.value,
                                    itemId:
                                        snapshot.data![index].itemId.toString(),
                                    category: snapshot.data![index].category,
                                    subCategory:
                                        snapshot.data![index].subCategory,
                                    discount:
                                        snapshot.data![index].discount.toInt()),
                              );
                            },
                            child: _buildlistTile(
                                context,
                                snapshot.data![index].itemImg,
                                snapshot.data![index].itemName,
                                snapshot.data![index].category,
                                snapshot.data![index].subCategory,
                                snapshot.data![index].totalPrice,
                                snapshot.data![index].discount.toInt()),
                          ),
                        );
                      })
                  : Column(
                      children: [
                        TextWidget(
                          title: 'No items here yet.',
                          fontSize: 28.sp,
                        ),
                      ],
                    );
            } else if (snapshot.hasError) {
              print('Error : ' + snapshot.error.toString());
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              );
            } else {
              return Container();
            }
          },
        )),
      ),
    );
  }
}
