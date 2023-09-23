import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:grocery_app/pages/AdminScreens/InventoryScreens/EditItems/state.dart';

class EditItemController extends GetxController {
  final state = EditItemState();
  final allItemRef = FirebaseFirestore.instance.collection('Items').snapshots();
}