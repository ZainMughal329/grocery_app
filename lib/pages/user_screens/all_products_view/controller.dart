
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:grocery_app/pages/user_screens/all_products_view/index.dart';
import 'package:grocery_app/pages/user_screens/cart_directory/index.dart';

import '../../../components/models/item_model.dart';

class AllProductsController extends GetxController {
  final state = AllProductsState();

  final items =
  FirebaseFirestore.instance.collection('Items').snapshots();

  AllProductsController();

  Future<List<ItemModel>> getAllItemsData() async {
    final snapshot =
    await FirebaseFirestore.instance.collection('Items').get();
    final itemData = snapshot.docs.map((e) => ItemModel.fromJson(e)).toList();
    return itemData;
  }

  Future<List<ItemModel>> getAndShowALlItemsData() async {
    return await getAllItemsData();
  }

}
