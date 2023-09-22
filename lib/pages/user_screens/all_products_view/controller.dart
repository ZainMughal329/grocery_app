
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:grocery_app/pages/user_screens/all_products_view/index.dart';
import 'package:grocery_app/pages/user_screens/cart_directory/index.dart';

class AllProductsController extends GetxController {
  final state = AllProductsState();

  final items =
  FirebaseFirestore.instance.collection('Items').snapshots();

  AllProductsController();

}
