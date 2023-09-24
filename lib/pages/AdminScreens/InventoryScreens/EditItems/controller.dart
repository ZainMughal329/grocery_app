import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/reuseable/snackbar_widget.dart';
import 'package:grocery_app/pages/AdminScreens/InventoryScreens/EditItems/state.dart';

class EditItemController extends GetxController {
  final state = EditItemState();
  final allItemRef = FirebaseFirestore.instance.collection('Items').snapshots();


  bool val = true;

  setval(bool value){
    val = value;
  }



  Future<void> deleteItem (String id)async{
    await FirebaseFirestore.instance.collection('Items').doc(id).delete().then((value){
      Snackbar.showSnackBar('Delete', "Item deleted Successfully");
    }).onError((error, stackTrace){
      Snackbar.showSnackBar("Error", error.toString());
    });
  }

}