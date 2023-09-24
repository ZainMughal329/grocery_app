import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckOutState {


  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  Rx<bool> loading = false.obs;




  Rx<String> addressLabel = 'Select'.obs;
  Rx<String> paymentMethod = 'Select'.obs;

  List<DropdownMenuItem> labelList = [
    DropdownMenuItem(child: Text('Home'),value: 'Home',),
    DropdownMenuItem(child: Text('Office'),value: 'Office',),
  ];

  List<DropdownMenuItem> paymentList = [
    DropdownMenuItem(child: Text('Cash on Delivery'),value: 'Cash on Delivery',),
    DropdownMenuItem(child: Text('Card Payment'),value: 'Card Payment',),
  ];

}