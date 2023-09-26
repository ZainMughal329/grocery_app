import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/models/place_order_model.dart';
import 'package:grocery_app/components/reuseable/snackbar_widget.dart';
import 'package:grocery_app/components/routes/name.dart';
import 'package:grocery_app/components/routes/routes.dart';
import 'package:grocery_app/components/services/cart_controller_reuseable.dart';
import 'package:grocery_app/pages/user_screens/checkOut_screen/state.dart';

import '../details/controller.dart';

class CheckOutController extends GetxController {
  final state = CheckOutState();
  final allOrdersRef = FirebaseFirestore.instance.collection('allOrders');
  final cartCon = Get.find<CartControllerReuseAble>();

  void setLoading(bool value) {
    state.loading.value = value;
  }

  Future<void> addOrder(
    PlaceOrderModel orderData,
    String timeStamp,
  ) async {
    setLoading(true);
    // final id = DateTime.timestamp().microsecondsSinceEpoch.toString();
    try {
      await allOrdersRef
          .doc(timeStamp)
          .set(orderData.toJson())
          .then((value) async {
        setLoading(false);
        Snackbar.showSnackBar("Order Placed", "Successfully");
        // Get.offNamed(AppRoutes.homeScreen);
        // await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('cartList');


        final CollectionReference collectionReference = FirebaseFirestore
            .instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('cartList');

        final QuerySnapshot querySnapshot = await collectionReference.get();
        for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
          await documentSnapshot.reference.delete().then((value) {
            cartCon.totalPrice.value = 0;
            print(
              'Price of is :' + cartCon.totalPrice.value.toString(),
            );
            print('Deleted success');
            // cartCon.totalPrice.value = 0;

            final detailCon = Get.put(DetailsController());
            print(
              'object:' + cartCon.totalPrice.value.toString(),
            );
            detailCon.fetchData();
          }).onError((error, stackTrace) {
            print('Error is : ' + error.toString());
          });
        }
        state.addressController.clear();
        state.phoneController.clear();
        state.nameController.clear();
        state.addressLabel.value = '';
        state.paymentMethod.value = '';
        cartCon.totalPrice.value = 0;
        Get.back();
        Get.back();
      }).onError((error, stackTrace) {
        setLoading(false);

        Snackbar.showSnackBar("Error", error.toString());
      });
    } catch (e) {
      setLoading(false);
      Snackbar.showSnackBar("Error", e.toString());
    }
  }

  deleteCartList() async {
    try {
      final CollectionReference collectionReference = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('cartList');

      cartCon.totalPrice.value = 0;
      print(
        'Price of is :' + cartCon.totalPrice.value.toString(),
      );

      final QuerySnapshot querySnapshot = await collectionReference.get();
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        await documentSnapshot.reference.delete().then((value) {
          print('Deleted success');
          // cartCon.totalPrice.value = 0;

          final detailCon = Get.put(DetailsController());
          print(
            'object:' + cartCon.totalPrice.value.toString(),
          );
          detailCon.fetchData();
        }).onError((error, stackTrace) {
          print('Error is : ' + error.toString());
        });
      }
      state.addressController.clear();
      state.phoneController.clear();
      state.nameController.clear();
      state.addressLabel.value = '';
      state.paymentMethod.value = '';
      cartCon.totalPrice.value = 0;
    } catch (e) {
      print('e' + e.toString());
    }
  }

  deleteOrderList() async {
    try {
      final CollectionReference collectionReference = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('orderList');
      cartCon.totalPrice.value = 0;
      print(
        'Price of is :' + cartCon.totalPrice.value.toString(),
      );

      final QuerySnapshot querySnapshot = await collectionReference.get();
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        await documentSnapshot.reference.delete().then((value) {
          print('Deleted success');
          // cartCon.totalPrice.value = 0;

          final detailCon = Get.put(DetailsController());
          print(
            'object:' + cartCon.totalPrice.value.toString(),
          );
          detailCon.fetchData();
        }).onError((error, stackTrace) {
          print('Error is : ' + error.toString());
        });
      }
      state.addressController.clear();
      state.phoneController.clear();
      state.nameController.clear();
      state.addressLabel.value = '';
      state.paymentMethod.value = '';
      cartCon.totalPrice.value = 0;
    } catch (e) {
      print('e' + e.toString());
    }
  }
}
