import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:grocery_app/pages/AdminScreens/orders/CancledOrders/state.dart';

class CanceledOrderController extends GetxController {
  final state = CanceledOrderState();
  final dbRef =  FirebaseFirestore.instance.collection('allOrders').where('status', isEqualTo: 'cancelled').snapshots();
}