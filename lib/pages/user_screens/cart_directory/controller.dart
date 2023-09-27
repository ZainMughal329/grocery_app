import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:grocery_app/pages/user_screens/cart_directory/index.dart';
import 'package:grocery_app/pages/user_screens/checkOut_screen/view.dart';
import 'package:grocery_app/pages/user_screens/details/controller.dart';

import '../../../components/models/order_model.dart';
import '../../../components/reuseable/snackbar_widget.dart';
import '../../../components/services/cart_controller_reuseable.dart';

class MyCartController extends GetxController {
  final state = MyCartState();
  // String docId = '';
  MyCartController();

  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;



  final orderList = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('cartList')
      .snapshots();



  updateQuantityToOne(String id, int itemQty) async {
    await db
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('cartList')
        .doc(id)
        .update({
      'itemQty': itemQty + 1,
    }).then((value) {
      print('success');
    });
  }

  removeQuantityToOne(String id, int itemQty) async {
    await db
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('cartList')
        .doc(id)
        .update({
      'itemQty': itemQty - 1,
    }).then((value) {
      print('success');
    });
  }

  deleteItem(String id) async {
    await db
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('cartList')
        .doc(id)
        .delete()
        .then((value) async {
      print('deleted!');
    });
  }

  deleteCartList() async {
    final cartCon = Get.find<CartControllerReuseAble>();
    cartCon.totalPrice.value = 0;
    final CollectionReference collectionReference = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('cartList');

    final QuerySnapshot querySnapshot = await collectionReference.get();
    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      await documentSnapshot.reference.delete().then((value) {
        print('Deleted success');

        final detailsCon = Get.put(DetailsController());
        detailsCon.fetchData();
      }).onError((error, stackTrace) {
        print('Error is : ' + error.toString());
      });
    }
  }

  RxInt totalPrice = 0.obs;

  void calculateTotalPrice(List<Map<String, dynamic>> items, int initialPrice) {
    int total = initialPrice;
    for (var item in items) {
      int price = item['totalPrice'].toInt();
      int quantity = item['itemQty'].toInt();
      total += (price * quantity);
    }
    totalPrice.value = total;
  }






}
