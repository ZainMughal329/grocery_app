import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/pages/session_sreens/splash/controller.dart';

class SplashView extends GetView<SplashScreenController> {
  const SplashView({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    controller.checkUserIsLogin();
    return const Scaffold(
      body: SafeArea(
        child: Center(child: Text("Splash Screen"),),
      ),
    );
  }
}
