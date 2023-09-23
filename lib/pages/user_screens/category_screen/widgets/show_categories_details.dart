import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/colors/light_app_colors.dart';
import 'package:grocery_app/components/reuseable/icon_widget.dart';
import 'package:grocery_app/components/reuseable/text_widget.dart';
import 'package:grocery_app/components/routes/name.dart';
import 'package:grocery_app/pages/user_screens/all_products_view/controller.dart';
import 'package:grocery_app/pages/user_screens/cart_directory/controller.dart';
import 'package:grocery_app/pages/user_screens/category_screen/controller.dart';
import 'package:grocery_app/pages/user_screens/faqs/controller.dart';

import '../../details/details.dart';

class ShowAllCategoriesProductsScreen extends GetView<CategoryController> {
  String category;

  ShowAllCategoriesProductsScreen({
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final con = Get.put(CategoryController());
    return Scaffold(
      body: SafeArea(
          child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            elevation: 2,
            forceElevated: true,
            pinned: true,
            title: TextWidget(
              title: category,
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
            delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.only(bottom: 30.h),
                child: Container(
                    padding: EdgeInsets.only(bottom: 30.h),
                    height: Get.height,
                    child: FutureBuilder(
                      future: con.getAndShowALlItemsData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                if (snapshot.data![index].category ==
                                    category) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.w, vertical: 20.h),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(
                                          () => DetailsScreen(
                                            category:
                                                snapshot.data![index].title,
                                            itemImg:
                                                snapshot.data![index].imageUrl,
                                            price: snapshot.data![index].price,
                                            itemQty:
                                                snapshot.data![index].priceQty,
                                            userName: con.state.username.value,
                                            itemId: snapshot.data![index].itemId
                                                .toString(),
                                          ),
                                        );
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 20.h),
                                            height: 200,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  height: 150.h,
                                                  width: 100.w,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                  )),
                                                  child: snapshot.data![index]
                                                              .imageUrl !=
                                                          ''
                                                      ? Image.network(
                                                          snapshot.data![index]
                                                              .imageUrl,
                                                          fit: BoxFit.fill,
                                                        )
                                                      : IconWidget(
                                                          iconData: Icons
                                                              .shopping_cart_outlined),
                                                ),
                                                // SizedBox(
                                                //   width: 15.w,
                                                // ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        TextWidget(
                                                          title: snapshot
                                                              .data![index]
                                                              .title,
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                        TextWidget(
                                                          title: snapshot
                                                              .data![index]
                                                              .priceQty,
                                                          fontSize: 12.sp,
                                                          textColor:
                                                              Colors.grey,
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        TextWidget(
                                                          title: 'Rs ' +
                                                              snapshot
                                                                  .data![index]
                                                                  .price
                                                                  .toString(),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),

                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Container(),
                                                    IconWidget(
                                                        iconData: Icons
                                                            .arrow_forward_ios),
                                                    Align(
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                      child: Container(
                                                        height: 30.h,
                                                        width: 120.w,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.green,
                                                        ),
                                                        child: Obx(
                                                          () => con.itemIds
                                                                  .contains(snapshot
                                                                      .data![
                                                                          index]
                                                                      .itemId)
                                                              ? Center(
                                                                  child:
                                                                      TextWidget(
                                                                    title:
                                                                        'Already in cart',
                                                                    textColor:
                                                                        Colors
                                                                            .white,
                                                                  ),
                                                                )
                                                              : GestureDetector(
                                                                  onTap: () {
                                                                    con.state.isTrue
                                                                            .value =
                                                                        !con
                                                                            .state
                                                                            .isTrue
                                                                            .value;
                                                                    print('object ' +
                                                                        con
                                                                            .state
                                                                            .isTrue
                                                                            .value
                                                                            .toString());
                                                                    print(con
                                                                        .itemIds
                                                                        .contains(snapshot
                                                                            .data![index]
                                                                            .itemId)
                                                                        .toString());

                                                                    DateTime
                                                                        currentDate =
                                                                        DateTime
                                                                            .now();
                                                                    DateTime dateTime = DateTime(
                                                                        currentDate
                                                                            .year,
                                                                        currentDate
                                                                            .month,
                                                                        currentDate
                                                                            .day);
                                                                    con.addDataToFirebase(
                                                                      controller
                                                                          .state
                                                                          .username
                                                                          .value,
                                                                      snapshot
                                                                          .data![
                                                                              index]
                                                                          .price,
                                                                      snapshot
                                                                          .data![
                                                                              index]
                                                                          .category,
                                                                      dateTime,
                                                                      1,
                                                                      snapshot
                                                                          .data![
                                                                              index]
                                                                          .itemId
                                                                          .toString(),
                                                                      snapshot
                                                                          .data![
                                                                              index]
                                                                          .imageUrl
                                                                          .toString(),
                                                                    );
                                                                  },
                                                                  child: Center(
                                                                    child:
                                                                        TextWidget(
                                                                      title:
                                                                          'Add to cart',
                                                                      textColor:
                                                                          Colors
                                                                              .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                        ),
                                                      ),
                                                      // Container(
                                                      //   height: 30.h,
                                                      //   width: 120.w,
                                                      //   decoration: BoxDecoration(
                                                      //     color: Colors.green,
                                                      //   ),
                                                      //   child: Center(
                                                      //     child: TextWidget(
                                                      //       title: 'Add to cart',
                                                      //       textColor: Colors.white,
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            height: 4.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              });
                        } else if (snapshot.hasError) {
                          print('Error');
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
            ]),
          ),
        ],
      )),
      // appBar: AppBar(
      //   title: TextWidget(
      //     title: category,
      //     fontSize: 18.sp,
      //   ),
      //   leading: IconButton(
      //     onPressed: () {
      //       Get.offAndToNamed(AppRoutes.categoryScreen);
      //     },
      //     icon: IconWidget(
      //       iconData: Icons.arrow_back,
      //     ),
      //   ),
      //   actions: [
      //     IconButton(onPressed: (){}, icon: IconWidget(iconData: Icons.share,),),
      //     SizedBox(width: 5.w,),
      //     IconButton(onPressed: (){}, icon: IconWidget(iconData: Icons.search,),),
      //     SizedBox(width: 5.w,),
      //
      //     IconButton(onPressed: (){}, icon: IconWidget(iconData: Icons.shopping_cart,),),
      //     SizedBox(width: 5.w,),
      //
      //   ],
      //   backgroundColor: LightAppColor.bgColor,
      // ),
      // body: Container(
      //     child: StreamBuilder<QuerySnapshot>(
      //       stream: con.items,
      //       builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
      //         if (snapshot.hasData) {
      //           return ListView.builder(
      //               itemCount: snapshot.data!.docs.length,
      //               itemBuilder: (context, index) {
      //                 if (snapshot.data!.docs[index]['category'] == category) {
      //                   return Padding(
      //                     padding: EdgeInsets.symmetric(
      //                         horizontal: 15.w, vertical: 20.h),
      //                     child: Column(
      //                       children: [
      //                         Container(
      //                           padding: EdgeInsets.symmetric(vertical: 20.h),
      //                           height: 200,
      //                           child: Row(
      //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                             children: [
      //                               Container(
      //                                 height: 150.h,
      //                                 width: 100.w,
      //                                 decoration: BoxDecoration(
      //                                     border: Border.all(
      //                                       color: Colors.grey.withOpacity(0.5),
      //                                     )
      //                                 ),
      //                                 child:snapshot.data!.docs[index]['imageUrl'] != '' ? Image.network(
      //                                   snapshot.data!.docs[index]['imageUrl'],fit: BoxFit.fill,
      //                                 ) : IconWidget(iconData: Icons.shopping_cart_outlined),
      //                               ),
      //                               // SizedBox(
      //                               //   width: 15.w,
      //                               // ),
      //                               Column(
      //                                 crossAxisAlignment: CrossAxisAlignment.start,
      //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                                 children: [
      //                                   Column(
      //                                     crossAxisAlignment: CrossAxisAlignment.start,
      //                                     children: [
      //                                       TextWidget(
      //                                         title: snapshot.data!.docs[index]
      //                                         ['title'],
      //                                         fontSize: 16.sp,
      //                                         fontWeight: FontWeight.w500,
      //                                       ),
      //                                       TextWidget(
      //                                         title: snapshot.data!.docs[index]
      //                                         ['priceQty'],
      //                                         fontSize: 12.sp,
      //                                         textColor: Colors.grey,
      //                                       ),
      //                                     ],
      //                                   ),
      //                                   Row(
      //                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                                     children: [
      //                                       TextWidget(
      //                                         title: 'Rs ' +
      //                                             snapshot.data!.docs[index]['price']
      //                                                 .toString(),
      //                                         fontWeight: FontWeight.bold,
      //                                       ),
      //
      //                                     ],
      //                                   ),
      //                                 ],
      //                               ),
      //
      //                               Column(
      //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                                 crossAxisAlignment: CrossAxisAlignment.end,
      //                                 children: [
      //                                   Container(),
      //                                   IconWidget(iconData: Icons.arrow_forward_ios),
      //                                   Align(
      //                                     alignment: Alignment.bottomLeft,
      //                                     child: Container(
      //                                       height: 30.h,
      //                                       width: 120.w,
      //                                       decoration: BoxDecoration(
      //                                         color: Colors.green,
      //                                       ),
      //                                       child: Center(
      //                                         child: TextWidget(
      //                                           title: 'Add to cart',
      //                                           textColor: Colors.white,
      //                                         ),
      //                                       ),
      //                                     ),
      //                                   ),
      //                                 ],
      //                               ),
      //                             ],
      //                           ),
      //                         ),
      //                         Divider(color: Colors.black,height: 4.0,),
      //                       ],
      //                     ),
      //                   );
      //                 } else {
      //                   return Container();
      //                 }
      //               });
      //         } else if (snapshot.hasError) {
      //           print('Error');
      //           return Center(
      //             child: CircularProgressIndicator(
      //               color: Colors.orange,
      //             ),
      //           );
      //         } else {
      //           return Container();
      //         }
      //       },
      //     )),
    );
  }
}
