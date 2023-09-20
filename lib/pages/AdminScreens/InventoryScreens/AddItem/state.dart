import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddItemState {

  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final priceQtyController = TextEditingController();
  final stockController = TextEditingController();
  final discountController = TextEditingController();

  RxString buttonValue = 'Select'.obs;


}