import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class SignInState {

  RxBool loading = false.obs;
  RxBool obsText = true.obs;



  final emailController = TextEditingController();
  final passController = TextEditingController();
  final phoneController = TextEditingController();
  final userNameController = TextEditingController();

}