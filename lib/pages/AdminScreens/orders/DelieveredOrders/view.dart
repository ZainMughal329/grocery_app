import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/colors/light_app_colors.dart';
import 'package:grocery_app/components/reuseable/snackbar_widget.dart';
import 'package:grocery_app/components/reuseable/text_widget.dart';
import 'package:grocery_app/pages/AdminScreens/orders/DelieveredOrders/controller.dart';
import 'package:grocery_app/pages/AdminScreens/orders/OrderDetail/view.dart';
import 'package:grocery_app/pages/AdminScreens/orders/shippedOrders/controller.dart';
import 'package:intl/intl.dart';
class DeliveredOrderView extends GetView<DeliveredOrderController> {
   DeliveredOrderView({Key? key}) : super(key: key);
  final controller = Get.put<DeliveredOrderController>(DeliveredOrderController());
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
         : Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         TextWidget(title: "No Orders Yet"),
       ],
     )

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
           'Order Detail',
           style: TextStyle(color: Colors.white, fontSize: 20.sp),
         ),

       ),
       body: SafeArea(
         child: StreamBuilder<QuerySnapshot>(
           stream: controller.dbRef,
           builder:
               (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
             if (snapshot.hasError) {
               return Container(
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     TextWidget(title: "No Orders Yet"),
                   ],
                 ) ,
               );
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
                   return snapshot.hasData ? _buildlistTile(
                       context, snapshot, index, formattedDate) : Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       TextWidget(title: "No Orders Yet"),
                     ],
                   );
                 },
               );
             }
             return Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 TextWidget(title: "No Orders Yet"),
               ],
             );
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
