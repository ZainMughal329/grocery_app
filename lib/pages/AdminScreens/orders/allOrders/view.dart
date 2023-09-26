import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/colors/light_app_colors.dart';
import 'package:grocery_app/components/reuseable/snackbar_widget.dart';
import 'package:grocery_app/components/reuseable/text_widget.dart';
import 'package:grocery_app/pages/AdminScreens/orders/OrderDetail/view.dart';
import 'package:grocery_app/pages/AdminScreens/orders/allOrders/controller.dart';
// import 'package:grocery_app/pages/AdminScreens/orders/controller.dart';
import 'package:intl/intl.dart';

class OrdersView extends GetView<OrdersController> {
  OrdersView({Key? key}) : super(key: key);

  Widget _buildlistTile(BuildContext context,
      AsyncSnapshot<QuerySnapshot> snapshot, index, String datetime) {
    if(snapshot.hasError){
      Snackbar.showSnackBar("Error", snapshot.error.toString());
      return Container(child: CircularProgressIndicator(color: LightAppColor.btnColor,),);
    }
    if(snapshot.connectionState==ConnectionState.waiting){
      return Container(child: CircularProgressIndicator(color: LightAppColor.btnColor,),);
    }
    return snapshot.hasData
            ? Card(
                elevation: 5.0,
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: ListTile(
                    leading: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Text(
                            snapshot.data!.docs[index]['name'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            datetime,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                    // title: Text(
                    //   snapshot.data!.docs[index]['name'],
                    //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    // ),
                    subtitle: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 5.0),
                            Text(
                              snapshot.data!.docs[index]['number'],
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              snapshot.data!.docs[index]['paymentMethod']
                                  .toString(),
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              "Address: " +
                                  snapshot.data!.docs[index]['address']
                                      .toString(),
                              style: TextStyle(fontSize: 14),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'RS${snapshot.data!.docs[index]['orderPrice']}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    trailing: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(OrderDetailView(
                                  orderId: snapshot.data!.docs[index]
                                      ['orderId']));
                            },
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.blue,
                              size: 25.sp,
                            ),
                          ),
                          TextWidget(title: snapshot.data!.docs[index]['status']
                              .toString().capitalizeFirst.toString(),),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : Container()
        // snapshot.data!.docs[index]['category'].toString()==value ? Card(
        //   elevation: 5.0,
        //   margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        //   child: Container(
        //     decoration: BoxDecoration(color: Colors.white),
        //     child: ListTile(
        //       contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        //       leading: Container(
        //         padding: EdgeInsets.only(right: 12.0),
        //         decoration: BoxDecoration(
        //             border: Border(
        //                 right: BorderSide(width: 1.0, color: Colors.grey[200]!))),
        //         child: Image.network(snapshot.data!.docs[index]['imageUrl'], fit: BoxFit.cover, width: 50, height: 50,),  // assuming you store image URLs in firestore
        //       ),
        //       title: Text(
        //         snapshot.data!.docs[index]['title'],
        //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        //       ),
        //       subtitle: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: <Widget>[
        //           SizedBox(height: 5.0),
        //           Text(
        //             snapshot.data!.docs[index]['category'],
        //             style: TextStyle(fontSize: 14),
        //           ),
        //           SizedBox(height: 5.0),
        //           Text(
        //             snapshot.data!.docs[index]['subCategory'],
        //             style: TextStyle(fontSize: 14),
        //           ),
        //           SizedBox(height: 5.0),
        //           Text(
        //             "stock:"+snapshot.data!.docs[index]['stock'].toString(),
        //             style: TextStyle(fontSize: 14),
        //           ),
        //           SizedBox(height: 5.0),
        //           Row(
        //             children: [
        //               Text(
        //                 'RS${snapshot.data!.docs[index]['price']}',
        //                 style: TextStyle(
        //                     fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green),
        //               ),
        //               if (snapshot.data!.docs[index]['discount'] != null &&
        //                   snapshot.data!.docs[index]['discount'] > 0)
        //                 Padding(
        //                   padding: const EdgeInsets.only(left: 8.0),
        //                   child: Text(
        //                     '${snapshot.data!.docs[index]['discount']}% OFF',
        //                     style: TextStyle(
        //                         fontSize: 12, color: Colors.red),
        //                   ),
        //                 ),
        //             ],
        //           ),
        //         ],
        //       ),
        //       trailing: Column(
        //         mainAxisAlignment: MainAxisAlignment.start,
        //         children: [
        //           InkWell(
        //             onTap: (){
        //               // Get.toNamed(AppRoutes.inventoryEdit);
        //               // Get.to(()=>EditScreenView(id: snapshot.data!.docs[index]['itemId']));
        //
        //             },
        //
        //             child: Icon(Icons.edit, color: Colors.blue,size: 30.sp,),
        //           )
        //
        //         ],
        //       ),
        //     ),
        //   ),
        // ) : Container()
        ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightAppColor.btnColor,
        title:
            // TextWidget(title: 'Edit Inventory',textColor: LightAppColor.bgColor,fontSize: 16,),
            Text(
          'Edit Inventory',
          style: TextStyle(color: Colors.white, fontSize: 20.sp),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(
              50.h), // set the height of the custom app bar bottom
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical:
                    5.0), // Updated the padding based on your provided values
            child: Container(
              color: LightAppColor.btnColor.withOpacity(0.5),
              height:
                  50.0, // you provided this as 50.h (probably using screen_util or another package for responsive design)
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    title: "Apply Filter",
                    textColor: LightAppColor.bgColor,
                    fontSize: 16,
                  ), // This was TextWidget(title: "Apply Filter") in your code
                  DropdownButton(
                      iconEnabledColor: Colors.white,
                      hint: TextWidget(title: "All"),
                      items: [
                        DropdownMenuItem(
                          child: TextWidget(
                            title: 'All',
                          ),
                          value: 'All',
                        ),
                        DropdownMenuItem(
                          child: TextWidget(
                            title: 'HouseHold',
                          ),
                          value: 'HouseHold',
                        ),
                        DropdownMenuItem(
                          child: TextWidget(
                            title: 'Grocery',
                          ),
                          value: 'Grocery',
                        ),
                        DropdownMenuItem(
                          child: TextWidget(
                            title: 'Kitchen',
                          ),
                          value: 'Kitchen',
                        ),
                        DropdownMenuItem(
                          child: TextWidget(
                            title: 'Bathroom',
                          ),
                          value: 'Bathroom',
                        ),
                        DropdownMenuItem(
                          child: TextWidget(
                            title: 'Clothing',
                          ),
                          value: 'Clothing',
                        ),
                      ],
                      onChanged: (value) {}),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: controller.dbRef,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Container();
            }
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final timeinmili = int.parse(
                      snapshot.data!.docs[index]['orderId'].toString());
                  final dtime = DateTime.fromMicrosecondsSinceEpoch(timeinmili);
                  String formattedDate = DateFormat('dd-MM').format(dtime);
                  print(dtime);
                  return _buildlistTile(
                      context, snapshot, index, formattedDate);
                },
              );
            }
            return Container();
            // return ListView.builder(
            //   itemCount: snapshot.data!.docs.length,
            //   itemBuilder: (context, index){
            //     return ListTile(
            //       title: Text(snapshot.data[index]['name'].toString()),
            //     );
            //   },);
          },
        ),
      ),
    );
  }
}
