import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:grocery_app/pages/AdminScreens/orders/state.dart';

class OrdersController extends GetxController{
  final state = OrdersState();
  final dbRef = FirebaseFirestore.instance.collection('allOrders').snapshots();
}