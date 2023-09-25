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

  String timeId = '';

  void createTimeStamp() {
    timeId = DateTime.timestamp().microsecondsSinceEpoch.toString();
  }

  addDataToFirebase(
    final String userName,
    final int totalPrice,
    final String itemName,
    final DateTime dateTime,
    final int itemQty,
    final String itemId,
    final String itemImg,
    final String category,
    final String subCategory,
    final int discount,
    final String timeStamp,
  ) async {
    try {
      String docId = DateTime.timestamp().microsecondsSinceEpoch.toString();

      int tprice = totalPrice;
      await db
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('orderList')
          .doc(docId)
          .set(
            OrderModel(
              orderId: timeStamp,
              customerId: auth.currentUser!.uid.toString(),
              customerName: userName,
              totalPrice: totalPrice,
              dateTime: dateTime,
              itemName: itemName,
              itemQty: itemQty,
              itemId: itemId,
              itemImg: itemImg,
              category: category,
              subCategory: subCategory,
              discount: discount,
            ).toJson(),
          )
          .then((value) async {
        // cartCon.addTotalPrice(totalPrice);
      });
    } catch (e) {
      print(
        'Error is : ' + e.toString(),
      );
    }
  }

  var stock = 0.obs; // Observable for the stock field

  // Function to fetch the stock value for a specific item document
  Future<void> fetchStockForItem(String itemId) async {
    try {
      final documentSnapshot = await FirebaseFirestore.instance
          .collection('Items')
          .doc(itemId)
          .get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        final data = documentSnapshot.data() as Map<String, dynamic>;
        final stockValue =
            data['stock'] ?? 0; // Default to 0 if 'stock' is not found
        stock.value = stockValue;
        print(stock.value.toString());
      } else {
        // Document doesn't exist
        stock.value = 0; // or any other default value
      }
    } catch (e) {
      print('Error fetching stock: $e');
    }
  }
}
