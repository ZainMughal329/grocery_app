// import 'package:air_proj_comp/pages/Administration/login/index.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:grocery_app/pages/AdminScreens/AdminHome/bindings.dart';
import 'package:grocery_app/pages/AdminScreens/AdminHome/view.dart';
import 'package:grocery_app/pages/AdminScreens/InventoryManagement/bindings.dart';
import 'package:grocery_app/pages/AdminScreens/InventoryManagement/view.dart';
import 'package:grocery_app/pages/AdminScreens/dashboard/bindings.dart';
import 'package:grocery_app/pages/AdminScreens/dashboard/view.dart';
import 'package:grocery_app/pages/AdminScreens/orders/bindings.dart';
import 'package:grocery_app/pages/AdminScreens/orders/view.dart';
import 'package:grocery_app/pages/session_sreens/forgot/index.dart';
import 'package:grocery_app/pages/session_sreens/login/index.dart';
import 'package:grocery_app/pages/session_sreens/signup/bindings.dart';
import 'package:grocery_app/pages/session_sreens/signup/view.dart';
import 'package:grocery_app/pages/session_sreens/splash/bindings.dart';
import 'package:grocery_app/pages/user_screens/home_screen/index.dart';

import '../../pages/session_sreens/splash/view.dart';
import 'name.dart';

class AppPages {
  // static List<String> history = [];
  static final List<GetPage> routes = [

    GetPage(
      name: AppRoutes.splashScreen,
      page: () =>  const SplashView(),
      binding: SplashScreenBindings(),
    ),

    GetPage(
      name: AppRoutes.signUpScreen,
      page: () =>  SignInView(),
      binding: SignInBindings(),
    ),

    GetPage(
      name: AppRoutes.logInScreen,
      page: () =>  LogInView(),
      binding: LogInBindings(),
    ),
    GetPage(
      name: AppRoutes.homeScreen,
      page: () => HomeView(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: AppRoutes.forgotScreen,
      page: () =>  ForgotView(),
      binding: ForgotBindings(),
    ),

    //AdminPages
    GetPage(
      name: AppRoutes.adminHomeScreen,
      page: () => AdminHomeView(),
      bindings: [
        AdminHomeBindings(),
        DashBoardBindings(),
        InventoryBindings(),
        OrdersBindings(),
      ],
    ),
    GetPage(
      name: AppRoutes.adminDashBoard,
      page: () => DashBoardView(),
      binding: DashBoardBindings(),
    ),
    GetPage(
      name: AppRoutes.adminInventoryMng,
      page: () => InventoryView(),
      binding: InventoryBindings(),
    ),
    GetPage(
      name: AppRoutes.adminOrdersMng,
      page: () => OrdersView(),
      binding: OrdersBindings(),
    ),
  ];
}
