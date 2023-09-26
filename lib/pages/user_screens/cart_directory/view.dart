import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/colors/light_app_colors.dart';
import 'package:grocery_app/components/reuseable/icon_widget.dart';
import 'package:grocery_app/components/reuseable/round_button.dart';
import 'package:grocery_app/components/reuseable/snackbar_widget.dart';
import 'package:grocery_app/components/reuseable/text_widget.dart';
import 'package:grocery_app/components/routes/name.dart';
import 'package:grocery_app/components/services/cart_controller_reuseable.dart';
import 'package:grocery_app/pages/user_screens/cart_directory/controller.dart';
import 'package:grocery_app/pages/user_screens/checkOut_screen/view.dart';
import 'package:grocery_app/pages/user_screens/details/controller.dart';
import 'package:grocery_app/pages/user_screens/faqs/controller.dart';

class MyCartScreen extends GetView<MyCartController> {
  final cartController = Get.find<CartControllerReuseAble>();

  // MyCartScreen({});

  Widget _buildlistTile(
      BuildContext context,
      String img,
      String title,
      String category,
      String subCategory,
      int price,
      int discount,
      String orderId,
      String itemId,
      // int stock,
      int itemQty) {
    return Card(
      elevation: 5.0,
      // margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        // height: 00.h,
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
                        decoration: TextDecoration.lineThrough),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'RS ' +
                          cartController
                              .calculateDiscountedPrice(price, discount)
                              .toString(),
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ),
                ],
              ),
            ],
          ),
          trailing: Container(
            height: 40.h,
            width: 110.w,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: Colors.green,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  itemQty == 1
                      ? GestureDetector(
                          onTap: () {
                            // controller.fetchStockForItem(itemId);
                            controller.deleteItem(
                              orderId,
                            );

                            cartController.removeFromTotalPrice(cartController
                                .calculateDiscountedPrice(price, discount));
                            // cartController.updateStockValue(itemId, controller.stock.value);
                            final detailCon = Get.put(DetailsController());
                            detailCon.fetchData();
                          },
                          child: Center(
                            child: IconWidget(
                              iconData: Icons.delete_forever,
                              iconColor: Colors.green,
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            // controller.fetchStockForItem(itemId);
                            controller.removeQuantityToOne(
                              orderId,
                              itemQty,
                            );
                            cartController.removeFromTotalPrice(cartController
                                .calculateDiscountedPrice(price, discount));
                            // cartController.updateStockValue(itemId, controller.stock.value);
                          },
                          child: Container(
                            height: 20.w,
                            width: 20.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.green,
                              ),
                            ),
                            child: Center(
                              child: IconWidget(
                                iconData: Icons.remove,
                                iconColor: Colors.green,
                                fontSize: 17.sp,
                              ),
                            ),
                          ),
                        ),
                  TextWidget(title: itemQty.toString()),
                  GestureDetector(
                    onTap: () {
                      // controller.fetchStockForItem(itemId);
                      controller.updateQuantityToOne(
                        orderId,
                        itemQty,
                      );
                      cartController.addTotalPrice(
                          cartController.calculateDiscountedPrice(price, discount));
                      // cartController.reduceStockValue(itemId, controller.stock.value);

                      // print('price is:' +
                      //     cartController
                      //         .addTotalPrice(controller
                      //             .calculateDiscountedPrice(price, discount))
                      //         .toString());
                    },
                    child: Container(
                      height: 20.w,
                      width: 20.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.green,
                        ),
                      ),
                      child: Center(
                        child: IconWidget(
                          iconData: Icons.add,
                          iconColor: Colors.green,
                          fontSize: 17.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
          title: 'My Cart',
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
            onPressed: () {
              controller.deleteCartList();
            },
            icon: IconWidget(
              iconData: Icons.delete_forever_outlined,
            ),
          ),
        ],
        backgroundColor: LightAppColor.bgColor,
      ),
        body: SafeArea(
      child:
            

            Stack(
              children: [
                Container(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: controller.orderList,
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.docs.length != 0) {
                          return ListView.builder(
                            // shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final now =
                                  snapshot.data!.docs[index]['dateTime'];
                              print(now.toString());
                              List<Map<String, dynamic>> items = [];

                              for (var doc in snapshot.data!.docs) {
                                items.add(
                                    doc.data() as Map<String, dynamic>);
                              }

                              print(
                                  'Total Price: \$${controller.totalPrice.value.toStringAsFixed(2)}');
                              controller.calculateTotalPrice(items,
                                  snapshot.data!.docs[index]['totalPrice']);
                              return Column(
                                children: [
                                  _buildlistTile(
                                    context,
                                    snapshot.data!.docs[index]['itemImg'],
                                    snapshot.data!.docs[index]['items'],
                                    snapshot.data!.docs[index]['category'],
                                    snapshot.data!.docs[index]
                                        ['subCategory'],
                                    snapshot.data!.docs[index]
                                        ['totalPrice'],
                                    snapshot.data!.docs[index]['discount'],
                                    snapshot.data!.docs[index]['orderId'],
                                    snapshot.data!.docs[index]['itemId'],
                                    // snapshot.data!.docs[index]['itemQty'],
                                    snapshot.data!.docs[index]['itemQty'],
                                  ),
                                  index == snapshot.data!.docs.length - 1
                                      ? Obx(() => RoundButton(
                                          title: 'CheckOut Rs:' +
                                              cartController.totalPrice
                                                  .toString(),
                                          onPress: () {

                                            Get.to(CheckOutView(
                                            ));

                                          }))
                                      : Container(),
                                ],
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                Image.asset('assets/cart1.png'),
                                Center(
                                    child: TextWidget(
                                  title:
                                      'Your cart is empty\n Let\'s fill it up by adding some items!',
                                  textColor: Colors.grey,
                                  textAlign: TextAlign.center,
                                )),
                                GestureDetector(
                                  onTap: () {
                                    // Get.toNamed(AppRoutes.homeScreen);
                                  },
                                  child: Container(
                                      height: 50.h,
                                      width: MediaQuery.of(context)
                                              .size
                                              .width *
                                          0.8.w,
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.orange,
                                      ),
                                      padding: EdgeInsets.all(16.0),
                                      child: Center(
                                        child: TextWidget(
                                          title: 'Start Shopping',
                                          textColor: Colors.white,
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          );
                        }
                      } else if (snapshot.hasError) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(
                //       top: MediaQuery.of(context).size.height - 150),
                //   child: RoundButton(
                //     title: "new button",
                //     onPress: () {},
                //   ),
                // )
              ],
            ),

      ),
    );
  }
}
