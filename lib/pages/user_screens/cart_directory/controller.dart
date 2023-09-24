import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:grocery_app/pages/user_screens/cart_directory/index.dart';

class MyCartController extends GetxController {
  final state = MyCartState();

  MyCartController();

  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  int calculateDiscountedPrice(int originalPrice, int? discountPercentage) {
    // Calculate the discount amount
    int discountAmount = (originalPrice * discountPercentage!) ~/ 100;

    // Calculate the discounted price
    int discountedPrice = originalPrice - discountAmount;

    return discountedPrice;
  }

  final orderList = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('orderList')
      .snapshots();

  updateQuantityToOne(String id, int itemQty) async {
    await db
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('orderList')
        .doc(id)
        .update({
      'itemQty': itemQty + 1,
    }).then((value) async {
     await db

          .collection('allOrdersList')
          .doc(id)
          .update({
        'itemQty': itemQty + 1,
      }).then((value) {
        print('success');
      });
    });
  }

  removeQuantityToOne(String id, int itemQty) async {
    await db
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('orderList')
        .doc(id)
        .update({
      'itemQty': itemQty - 1,
    }).then((value) async{
      await db

          .collection('allOrdersList')
          .doc(id)
          .update({
        'itemQty': itemQty + 1,
      }).then((value) {
        print('success');
      });
    });
  }


  deleteItem(String id) async {
    await db
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('orderList')
        .doc(id).delete().then((value) async {
      await db

          .collection('allOrdersList')
          .doc(id)
          .delete().then((value) {
        print('deleted!');
      });
    });
  }

  RxInt totalPrice = 0.obs;

  void calculateTotalPrice(List<Map<String, dynamic>> items , int initialPrice) {
    int total = initialPrice;
    for (var item in items) {
      int price = item['totalPrice'].toInt();
      int quantity = item['itemQty'].toInt();
      total += (price * quantity);
    }
    totalPrice.value = total;
  }


}
