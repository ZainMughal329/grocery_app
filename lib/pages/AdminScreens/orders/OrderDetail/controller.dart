import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/models/place_order_model.dart';
import 'package:grocery_app/components/reuseable/snackbar_widget.dart';
import 'package:grocery_app/components/services/session_controller.dart';
import 'package:grocery_app/pages/AdminScreens/orders/OrderDetail/state.dart';

class OrderDetailController extends GetxController {
  final state = OrderDetailsState();
  final dbref = FirebaseFirestore.instance.collection('allOrders');

  DocumentSnapshot? document;
  PlaceOrderModel? orderDetails;

  Future<void> fetchOrderDetails(String id) async {
    try {
      document = await dbref.doc(id).get();
      if (document!.exists) {
        orderDetails = PlaceOrderModel(
          orderId: id,
          customerId: document!['customerId'],
          name: document!['name'],
          number: document!['number'],
          address: document!['address'],
          addressLabel: document!['addressLabel'],
          paymentMethod: document!['paymentMethod'],
          orderPrice: document!['orderPrice'],
          status: document!['status'],
        );
        state.hint.value = document!['status'];
        state.loaded.value = true;
      }
    } catch (e) {
      Snackbar.showSnackBar("Error", e.toString());
    }
  }

  Future<void> changeStatus(String orderId, String uid, String status) async {
    try {
      await dbref.doc(orderId).update({
        'status': status,
      }).then((value) {
        updateOrderStatus(orderId, uid, status);
      }).onError((error, stackTrace) {
        Snackbar.showSnackBar("Error", error.toString());
      });
    } catch (e) {
      Snackbar.showSnackBar("Error", e.toString());
    }
  }

  Future<void> updateOrderStatus(
      String orderId, String uid, String newStatus) async {
    try {
      CollectionReference users = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('orderList');

      // Fetch all documents with the given orderId
      final orderDocs = await users.where('orderId', isEqualTo: orderId).get();
      for (QueryDocumentSnapshot doc in orderDocs.docs) {
        doc.reference.update({'status': newStatus});
      }

    } catch (e) {
      Snackbar.showSnackBar("Error", e.toString());
    }
  }
}
