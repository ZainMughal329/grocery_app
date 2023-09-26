import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/models/place_order_model.dart';
import 'package:grocery_app/components/reuseable/snackbar_widget.dart';
import 'package:grocery_app/components/routes/name.dart';
import 'package:grocery_app/components/routes/routes.dart';
import 'package:grocery_app/components/services/cart_controller_reuseable.dart';
import 'package:grocery_app/pages/user_screens/checkOut_screen/state.dart';

import '../../../components/models/order_model.dart';
import '../details/controller.dart';

class CheckOutController extends GetxController {
  final state = CheckOutState();
  final allOrdersRef = FirebaseFirestore.instance.collection('allOrders');

  void setLoading(bool value) {
    state.loading.value = value;
  }

  final orderList = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('cartList')
      .snapshots();

  Future<void> addOrder(
    PlaceOrderModel orderData,
    String timeStamp,
  ) async {
    setLoading(true);
    // final id = DateTime.timestamp().microsecondsSinceEpoch.toString();
    try {
      await allOrdersRef.doc(timeStamp).set(orderData.toJson()).then((value) {
        final cartCon = Get.find<CartControllerReuseAble>();
        setLoading(false);
        Snackbar.showSnackBar("Order Placed", "Successfully");

        state.addressController.clear();
        state.phoneController.clear();
        state.nameController.clear();
        state.addressLabel.value = '';
        state.paymentMethod.value = '';
        cartCon.totalPrice.value = 0;
        // Get.toNamed(AppRoutes.homeScreen);
      }).onError((error, stackTrace) {
        setLoading(false);

        Snackbar.showSnackBar("Error", error.toString());
      });
    } catch (e) {
      setLoading(false);
      Snackbar.showSnackBar("Error", e.toString());
    }
  }


  String timeId = '';

  void createTimeStamp() {
    timeId = DateTime.timestamp().microsecondsSinceEpoch.toString();
  }

  addDataToFirebase(
      final String userName,
      final int totalPrice,
      final String itemName,
      // final DateTime dateTime,
      final int itemQty,
      final String itemId,
      final String itemImg,
      final String category,
      final String subCategory,
      final int discount,
      ) async {
    try {
      String docId = DateTime.timestamp().microsecondsSinceEpoch.toString();

      int tprice = totalPrice;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('orderList')
          .doc(docId)
          .set(
        OrderModel(
          id: docId,
          orderId: timeId,
          customerId: FirebaseAuth.instance.currentUser!.uid.toString(),
          customerName: userName,
          totalPrice: totalPrice,
          // dateTime: dateTime,
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
        print("data added into firebase");
        final CollectionReference collectionReference = FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('cartList');

        // cartCon.totalPrice.value = 0;
        // print(
        //   'Price of is :' + cartCon.totalPrice.value.toString(),
        // );

        final QuerySnapshot querySnapshot = await collectionReference.get();
        for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
          await documentSnapshot.reference.delete().then((value) {
            print('Deleted success');
            // cartCon.totalPrice.value = 0;

            final detailCon = Get.put(DetailsController());

            detailCon.fetchData();
          }).onError((error, stackTrace) {
            print('Error is : ' + error.toString());
          });
        }
        print('Deleted cart data');
        // cartCon.addTotalPrice(totalPrice);
      });
    } catch (e) {
      print(
        'Error is : ' + e.toString(),
      );
    }
  }
}
