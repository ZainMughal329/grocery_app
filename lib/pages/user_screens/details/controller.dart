import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/models/order_model.dart';
import 'package:grocery_app/pages/user_screens/details/state.dart';

class DetailsController extends GetxController {
  final state = DetailsState();

  DetailsController();

  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;



  addDataToFirebase(
      final String userName,
      final int totalPrice,
      final String itemName,
      final DateTime dateTime,
      final int itemQty,) async {
    try {
      String timeStamp = DateTime
          .now()
          .microsecondsSinceEpoch
          .toString();
      await db
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('orderList')
          .doc(timeStamp)
          .set(
        OrderModel(
            orderId: timeStamp,
            customerId: auth.currentUser!.uid.toString(),
            customerName: userName,
            totalPrice: totalPrice,
            dateTime: dateTime,
            itemName: itemName,
            itemQty: itemQty)
            .toJson(),
      ).then((value) async {
        await db.collection('allOrdersList').doc(timeStamp).set(OrderModel(
            orderId: timeStamp,
            customerId: auth.currentUser!.uid.toString(),
            customerName: userName,
            totalPrice: totalPrice,
            dateTime: dateTime,
            itemName: itemName,
            itemQty: itemQty)
            .toJson(),).then((value) {
          print('Added to cart successfully');
        });
      });
    }catch(e) {
      print('Error is : ' + e.toString(),);
    }
  }

  // Future<void> updateDocument() async {
  //   try {
  //     await documentReference.update({
  //       'fieldName': 'updatedValue',
  //     });
  //     print('Document updated successfully.');
  //   } catch (e) {
  //     print('Error updating document: $e');
  //   }
  // }

  // updateCountValue()
}
