import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/routes/name.dart';
import 'package:grocery_app/components/services/session_controller.dart';
import 'package:grocery_app/pages/session_sreens/splash/state.dart';

class SplashScreenController extends GetxController{
  final state = SplashScreenState();
  final auth= FirebaseAuth.instance;


  void checkUserIsLogin () async{
    final user = auth.currentUser;

    Future.delayed(Duration(seconds: 3), (){
      if(user!=null){
        SessionController().userId = user.uid.toString();
        Get.offAndToNamed(AppRoutes.homeScreen);
      }else{
        Get.offAndToNamed(AppRoutes.logInScreen);
      }
    });
  }



}