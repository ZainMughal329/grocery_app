import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:grocery_app/pages/AdminScreens/orders/shippedOrders/state.dart';

class ShippedOrderController extends GetxController {
  final state = ShippedOrderState();
  final dbRef =  FirebaseFirestore.instance.collection('allOrders').where('status', isEqualTo: 'shipped').snapshots();
}