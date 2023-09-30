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
    if (snapshot.hasError) {
      Snackbar.showSnackBar("Error", snapshot.error.toString());
      return Container(
        child: CircularProgressIndicator(
          color: LightAppColor.btnColor,
        ),
      );
    }
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Container(
        child: CircularProgressIndicator(
          color: LightAppColor.btnColor,
        ),
      );
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                  snapshot.data!.docs[index]['name']
                      .toString()
                      .split('')
                      .take(5)
                      .join('')
                      .length >=
                      5
                      ? snapshot.data!.docs[index]['name']
                      .toString()
                      .split('')
                      .take(5)
                      .join('').toString() +
                      '...'
                      : snapshot.data!.docs[index]['name']
                      .toString()
                    ,
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

                subtitle: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 5.0),
                        Text(

                            snapshot.data!.docs[index]['number']
                                        .toString()
                                        .split('')
                                        .take(5)
                                        .join('')
                                        .length >=
                                    5
                                ? snapshot.data!.docs[index]['number']
                                        .toString()
                                        .split('')
                                        .take(5)
                                        .join('').toString() +
                                    '...'
                                : snapshot.data!.docs[index]['number']
                                    .toString()
                          ,
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
                              (snapshot.data!.docs[index]['address']
                                              .toString()
                                              .split('')
                                              .take(5)
                                              .join('')
                                              .length >=
                                          5
                                      ? snapshot.data!.docs[index]['address']
                                              .toString()
                                              .split('')
                                              .take(5)
                                              .join('') +
                                          '...'
                                      : snapshot.data!.docs[index]['address']
                                          .toString())
                                  .toString(),
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 5.0),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'RS ${snapshot.data!.docs[index]['orderPrice']}',
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
                              orderId: snapshot.data!.docs[index]['orderId']));
                        },
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.blue,
                          size: 25.sp,
                        ),
                      ),
                      TextWidget(
                        title: snapshot.data!.docs[index]['status']
                            .toString()
                            .capitalizeFirst
                            .toString(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : Container();
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
