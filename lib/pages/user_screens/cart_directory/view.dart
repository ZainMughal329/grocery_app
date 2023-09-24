import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/colors/light_app_colors.dart';
import 'package:grocery_app/components/reuseable/icon_widget.dart';
import 'package:grocery_app/components/reuseable/text_widget.dart';
import 'package:grocery_app/components/routes/name.dart';
import 'package:grocery_app/components/services/cart_controller_reuseable.dart';
import 'package:grocery_app/pages/user_screens/cart_directory/controller.dart';
import 'package:grocery_app/pages/user_screens/faqs/controller.dart';

class MyCartScreen extends GetView<MyCartController> {
  final cartController = Get.find<CartControllerReuseAble>();


  Widget _buildlistTile(BuildContext context, String img, String title,
      String category, String subCategory, int price, int discount , String orderId , int itemQty) {
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
                        decoration: TextDecoration.lineThrough
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'RS ' + controller.calculateDiscountedPrice(price, discount).toString(),
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
              borderRadius:
              BorderRadius.circular(
                  10),
            ),
            child: Padding(
              padding:
              const EdgeInsets.all(
                  8.0),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,
                children: [
                  itemQty ==
                      1
                      ? GestureDetector(
                    onTap: () {
                      controller
                          .deleteItem(
                        orderId,
                      );
                    },
                    child: Center(
                      child:
                      IconWidget(
                        iconData:
                        Icons
                            .delete_forever,
                        iconColor:
                        Colors
                            .green,
                      ),
                    ),
                  )
                      : GestureDetector(
                    onTap: () {
                      controller
                          .removeQuantityToOne(
                        orderId,itemQty,
                      );


                    },
                    child:
                    Container(
                      height:
                      20.w,
                      width: 20.w,
                      decoration:
                      BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(
                            20),
                        border:
                        Border
                            .all(
                          color: Colors
                              .green,
                        ),
                      ),
                      child:
                      Center(
                        child:
                        IconWidget(
                          iconData:
                          Icons.remove,
                          iconColor:
                          Colors.green,
                          fontSize:
                          17.sp,
                        ),
                      ),
                    ),
                  ),
                  TextWidget(
                      title: itemQty
                          .toString()),
                  GestureDetector(
                    onTap: () {
                      controller
                          .updateQuantityToOne(
                       orderId,itemQty,
                      );
                    },
                    child: Container(
                      height: 20.w,
                      width: 20.w,
                      decoration:
                      BoxDecoration(
                        borderRadius:
                        BorderRadius
                            .circular(
                            20),
                        border:
                        Border.all(
                          color: Colors
                              .green,
                        ),
                      ),
                      child: Center(
                        child:
                        IconWidget(
                          iconData:
                          Icons.add,
                          iconColor:
                          Colors
                              .green,
                          fontSize:
                          17.sp,
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
        body: SafeArea(
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                forceElevated: true,
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
                backgroundColor: LightAppColor.bgColor,
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                // Container(),

                Container(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: controller.orderList,
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.docs.length != 0) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final now =
                                    snapshot.data!.docs[index]['dateTime'];
                                print(now.toString());
                                List<Map<String, dynamic>> items = [];

                                for (var doc in snapshot.data!.docs) {
                                  items.add(doc.data() as Map<String, dynamic>);
                                }

                                print('Total Price: \$${controller.totalPrice.value.toStringAsFixed(2)}');
                                controller.calculateTotalPrice(items,snapshot.data!
                                    .docs[index]
                                ['totalPrice']);
                                return _buildlistTile(
                                    context, snapshot.data!
                                    .docs[index]
                                ['itemImg'], snapshot.data!
                                    .docs[index]
                                ['items'], snapshot.data!
                                    .docs[index]
                                ['category'], snapshot.data!
                                    .docs[index]
                                ['subCategory'], snapshot.data!
                                    .docs[index]
                                ['totalPrice'], snapshot.data!
                                    .docs[index]
                                ['discount'],
                                    snapshot.data!
                                        .docs[index]
                                    ['orderId'],
                                    snapshot.data!
                                        .docs[index]
                                    ['itemQty']
                                );
                                //   Padding(
                                //   padding: EdgeInsets.symmetric(
                                //       horizontal: 15.w, vertical: 20.h),
                                //   child: Column(
                                //     children: [
                                //       Container(
                                //         padding: EdgeInsets.symmetric(
                                //             vertical: 20.h),
                                //         height: 200,
                                //         child: Row(
                                //           mainAxisAlignment:
                                //               MainAxisAlignment.spaceBetween,
                                //           children: [
                                //             Row(
                                //               children: [
                                //                 Container(
                                //                   height: 150.h,
                                //                   width: 100.w,
                                //                   decoration: BoxDecoration(
                                //                       border: Border.all(
                                //                     color: Colors.grey
                                //                         .withOpacity(0.5),
                                //                   )),
                                //                   child: snapshot.data!
                                //                                   .docs[index]
                                //                               ['itemImg'] !=
                                //                           ''
                                //                       ? Image.network(
                                //                           snapshot.data!
                                //                                   .docs[index]
                                //                               ['itemImg'],
                                //                           fit: BoxFit.fill,
                                //                         )
                                //                       : IconWidget(
                                //                           iconData: Icons
                                //                               .shopping_cart_outlined),
                                //                 ),
                                //                 SizedBox(
                                //                   width: 7.w,
                                //                 ),
                                //                 Column(
                                //                   crossAxisAlignment:
                                //                       CrossAxisAlignment.start,
                                //                   mainAxisAlignment:
                                //                       MainAxisAlignment
                                //                           .spaceBetween,
                                //                   children: [
                                //                     Column(
                                //                       crossAxisAlignment:
                                //                           CrossAxisAlignment
                                //                               .start,
                                //                       children: [
                                //                         TextWidget(
                                //                           title: snapshot.data!
                                //                                   .docs[index]
                                //                               ['items'],
                                //                           fontSize: 16.sp,
                                //                           fontWeight:
                                //                               FontWeight.w500,
                                //                         ),
                                //                         TextWidget(
                                //                           title: snapshot
                                //                               .data!
                                //                               .docs[index]
                                //                                   ['itemQty']
                                //                               .toString(),
                                //                           fontSize: 12.sp,
                                //                           textColor:
                                //                               Colors.grey,
                                //                         ),
                                //                       ],
                                //                     ),
                                //                     Row(
                                //                       mainAxisAlignment:
                                //                           MainAxisAlignment
                                //                               .spaceBetween,
                                //                       children: [
                                //                         TextWidget(
                                //                           title: 'Rs ' +
                                //                               snapshot
                                //                                   .data!
                                //                                   .docs[index][
                                //                                       'totalPrice']
                                //                                   .toString(),
                                //                           fontWeight:
                                //                               FontWeight.bold,
                                //                         ),
                                //                       ],
                                //                     ),
                                //                   ],
                                //                 ),
                                //               ],
                                //             ),
                                //             Column(
                                //               mainAxisAlignment:
                                //                   MainAxisAlignment
                                //                       .spaceBetween,
                                //               crossAxisAlignment:
                                //                   CrossAxisAlignment.end,
                                //               children: [
                                //                 Container(),
                                //                 // IconWidget(
                                //                 //     iconData: Icons.arrow_forward_ios),
                                //                 Align(
                                //                   alignment:
                                //                       Alignment.bottomLeft,
                                //                   child: Container(
                                //                     height: 40.h,
                                //                     width: 110.w,
                                //                     decoration: BoxDecoration(
                                //                       color: Colors.transparent,
                                //                       border: Border.all(
                                //                         color: Colors.green,
                                //                         width: 2.0,
                                //                       ),
                                //                       borderRadius:
                                //                           BorderRadius.circular(
                                //                               10),
                                //                     ),
                                //                     child: Padding(
                                //                       padding:
                                //                           const EdgeInsets.all(
                                //                               8.0),
                                //                       child: Row(
                                //                         mainAxisAlignment:
                                //                             MainAxisAlignment
                                //                                 .spaceBetween,
                                //                         children: [
                                //                           snapshot.data!.docs[
                                //                                           index]
                                //                                       [
                                //                                       'itemQty'] ==
                                //                                   1
                                //                               ? GestureDetector(
                                //                                   onTap: () {
                                //                                     controller
                                //                                         .deleteItem(
                                //                                       snapshot
                                //                                           .data!
                                //                                           .docs[index]['orderId'],
                                //                                     );
                                //                                     cartController
                                //                                         .removeFromTotalPrice(
                                //                                       snapshot
                                //                                           .data!
                                //                                           .docs[index]['totalPrice'],
                                //                                     );
                                //                                     cartController
                                //                                         .removeFromCart();
                                //                                   },
                                //                                   child: Center(
                                //                                     child:
                                //                                         IconWidget(
                                //                                       iconData:
                                //                                           Icons
                                //                                               .delete_forever,
                                //                                       iconColor:
                                //                                           Colors
                                //                                               .green,
                                //                                     ),
                                //                                   ),
                                //                                 )
                                //                               : GestureDetector(
                                //                                   onTap: () {
                                //                                     controller
                                //                                         .removeQuantityToOne(
                                //                                       snapshot
                                //                                           .data!
                                //                                           .docs[index]['orderId'],
                                //                                       snapshot
                                //                                           .data!
                                //                                           .docs[index]['itemQty'],
                                //                                     );
                                //                                     cartController
                                //                                         .removeFromTotalPrice(
                                //                                       snapshot
                                //                                           .data!
                                //                                           .docs[index]['totalPrice'],
                                //                                     );
                                //                                   },
                                //                                   child:
                                //                                       Container(
                                //                                     height:
                                //                                         20.w,
                                //                                     width: 20.w,
                                //                                     decoration:
                                //                                         BoxDecoration(
                                //                                       borderRadius:
                                //                                           BorderRadius.circular(
                                //                                               20),
                                //                                       border:
                                //                                           Border
                                //                                               .all(
                                //                                         color: Colors
                                //                                             .green,
                                //                                       ),
                                //                                     ),
                                //                                     child:
                                //                                         Center(
                                //                                       child:
                                //                                           IconWidget(
                                //                                         iconData:
                                //                                             Icons.remove,
                                //                                         iconColor:
                                //                                             Colors.green,
                                //                                         fontSize:
                                //                                             17.sp,
                                //                                       ),
                                //                                     ),
                                //                                   ),
                                //                                 ),
                                //                           TextWidget(
                                //                               title: snapshot
                                //                                   .data!
                                //                                   .docs[index][
                                //                                       'itemQty']
                                //                                   .toString()),
                                //                           GestureDetector(
                                //                             onTap: () {
                                //                               controller
                                //                                   .updateQuantityToOne(
                                //                                 snapshot.data!
                                //                                             .docs[
                                //                                         index]
                                //                                     ['orderId'],
                                //                                 snapshot.data!
                                //                                             .docs[
                                //                                         index]
                                //                                     ['itemQty'],
                                //                               );
                                //                               cartController
                                //                                   .addTotalPrice(
                                //                                 snapshot.data!
                                //                                             .docs[
                                //                                         index][
                                //                                     'totalPrice'],
                                //                               );
                                //                             },
                                //                             child: Container(
                                //                               height: 20.w,
                                //                               width: 20.w,
                                //                               decoration:
                                //                                   BoxDecoration(
                                //                                 borderRadius:
                                //                                     BorderRadius
                                //                                         .circular(
                                //                                             20),
                                //                                 border:
                                //                                     Border.all(
                                //                                   color: Colors
                                //                                       .green,
                                //                                 ),
                                //                               ),
                                //                               child: Center(
                                //                                 child:
                                //                                     IconWidget(
                                //                                   iconData:
                                //                                       Icons.add,
                                //                                   iconColor:
                                //                                       Colors
                                //                                           .green,
                                //                                   fontSize:
                                //                                       17.sp,
                                //                                 ),
                                //                               ),
                                //                             ),
                                //                           ),
                                //                         ],
                                //                       ),
                                //                     ),
                                //                   ),
                                //                 ),
                                //               ],
                                //             ),
                                //           ],
                                //         ),
                                //       ),
                                //       Divider(
                                //         color: Colors.black,
                                //         height: 4.0,
                                //       ),
                                //
                                //     ],
                                //   ),
                                // );
                              });
                        } else {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 100.h,),
                                Image.asset('assets/cart1.png'),
                                Center(
                                    child: TextWidget(
                                  title:
                                      'Your cart is empty\n Let\'s fill it up by adding some items!',
                                  textColor: Colors.grey,
                                  textAlign: TextAlign.center,
                                )),
                                Container(
                                    height: 50.h,
                                    width: MediaQuery.of(context).size.width *
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
              ]))
            ],
          ),
          // Obx(() =>Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Container(
          //       height: 50.h,
          //       width: double.infinity,
          //       margin: EdgeInsets.all(10),
          //       decoration: BoxDecoration(
          //         color: Colors.orange,
          //       ),
          //       // padding: EdgeInsets.all(16.0),
          //       child: Padding(
          //         padding: EdgeInsets.symmetric(
          //             vertical: 8.0,
          //             horizontal: 10.w),
          //         child: Row(
          //           mainAxisAlignment:
          //           MainAxisAlignment
          //               .spaceBetween,
          //           children: [
          //             TextWidget(
          //               title: 'CheckOut',
          //               textColor: Colors.white,
          //             ),
          //              TextWidget(
          //               title: 'Rs ' +
          //                   controller.totalPrice.value.toString(),
          //               textColor: Colors.white,
          //             ),
          //           ],
          //         ),
          //       )),
          // )),

        ],
      ),
    ));
  }
}
