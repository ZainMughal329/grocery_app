import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LogInState {

  RxBool loading = false.obs;
  RxBool obsText = true.obs;

  final emailController = TextEditingController();
  final passController = TextEditingController();

}