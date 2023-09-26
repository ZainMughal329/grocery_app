import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:grocery_app/pages/AdminScreens/orders/pendingOrders/state.dart';

class PendingOrderController extends GetxController {
  final state = PendingOrderState();
  final dbRef =  FirebaseFirestore.instance.collection('allOrders').where('status', isEqualTo: 'pending').snapshots();
}