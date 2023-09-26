import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:grocery_app/pages/AdminScreens/orders/DelieveredOrders/state.dart';

class DeliveredOrderController  extends GetxController {
  final state = DeliveredOrderState();
  final dbRef =  FirebaseFirestore.instance.collection('allOrders').where('status', isEqualTo: 'delivered').snapshots();
}