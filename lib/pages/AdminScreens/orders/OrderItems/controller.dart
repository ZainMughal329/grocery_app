import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/reuseable/snackbar_widget.dart';
import 'package:grocery_app/components/services/session_controller.dart';
import 'package:grocery_app/pages/AdminScreens/orders/OrderItems/state.dart';

import '../../../../components/models/order_model.dart';

class OrderItemsController extends GetxController {
  final state = OrderItemsState();

  Future<List<OrderModel>> getAllOrdersData(String customerId,String orderId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(customerId)
        .collection('orderList')
        .where('orderId', isEqualTo: orderId)
        .get();
    final itemData = snapshot.docs.map((e) => OrderModel.fromJson(e)).toList();
    return itemData;
  }

  Future<List<OrderModel>> getAndShowALlOrdersData(String customerId,String orderId) async {
    return await getAllOrdersData(customerId,orderId);
  }
}
