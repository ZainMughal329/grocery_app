// import 'package:air_proj_comp/pages/Administration/login/index.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:grocery_app/pages/AdminScreens/AdminHome/bindings.dart';
import 'package:grocery_app/pages/AdminScreens/AdminHome/view.dart';
import 'package:grocery_app/pages/AdminScreens/InventoryManagement/bindings.dart';
import 'package:grocery_app/pages/AdminScreens/InventoryManagement/view.dart';
import 'package:grocery_app/pages/AdminScreens/InventoryScreens/AddItem/bindings.dart';
import 'package:grocery_app/pages/AdminScreens/InventoryScreens/AddItem/view.dart';
import 'package:grocery_app/pages/AdminScreens/InventoryScreens/EditItems/bindings.dart';
import 'package:grocery_app/pages/AdminScreens/InventoryScreens/EditItems/view.dart';
import 'package:grocery_app/pages/AdminScreens/dashboard/bindings.dart';
import 'package:grocery_app/pages/AdminScreens/dashboard/view.dart';
import 'package:grocery_app/pages/AdminScreens/orders/bindings.dart';
import 'package:grocery_app/pages/AdminScreens/orders/view.dart';
import 'package:grocery_app/pages/session_sreens/forgot/index.dart';
import 'package:grocery_app/pages/session_sreens/login/index.dart';
import 'package:grocery_app/pages/session_sreens/signup/bindings.dart';
import 'package:grocery_app/pages/session_sreens/signup/view.dart';
import 'package:grocery_app/pages/session_sreens/splash/bindings.dart';
import 'package:grocery_app/pages/user_screens/all_products_view/bindings.dart';
import 'package:grocery_app/pages/user_screens/all_products_view/view.dart';
import 'package:grocery_app/pages/user_screens/category_screen/index.dart';
import 'package:grocery_app/pages/user_screens/details/bindings.dart';
import 'package:grocery_app/pages/user_screens/details/details.dart';
import 'package:grocery_app/pages/user_screens/faqs/bindings.dart';
import 'package:grocery_app/pages/user_screens/home_screen/index.dart';
import 'package:grocery_app/pages/user_screens/profile/index.dart';

import '../../pages/session_sreens/splash/view.dart';
import '../../pages/user_screens/faqs/view.dart';
import '../../pages/user_screens/help_center/index.dart';
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


    GetPage(
      name: AppRoutes.faqsScreen,
      page: () =>  FAQScreen(),
      binding: FAQSBindings(),
    ),

    GetPage(
      name: AppRoutes.helpCenterScreen,
      page: () =>  HelpCenterScreen(),
      binding: HelpCenterBindings(),
    ),


    GetPage(
      name: AppRoutes.categoryScreen,
      page: () =>  CategoryView(),
      binding: CategoryBindings(),
    ),

    GetPage(
      name: AppRoutes.categoryScreen,
      page: () =>  CategoryView(),
      binding: CategoryBindings(),
    ),

    GetPage(
      name: AppRoutes.detailsScreen,
      page: () =>  DetailsScreen(category: '', itemImg: '', price: 0, itemQty: '', userName: '',),
      binding: DetailsBinding(),
    ),


    GetPage(
      name: AppRoutes.allProductsScreen,
      page: () =>  AllProductsScreen(category: '', subCategory: ''),
      binding: AllProuctsBindings(),
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
    // InventoryPages
    GetPage(
      name: AppRoutes.inventoryAddItem,
      page: () => AddItemView(),
      binding: AddItemBindings(),
      transition: Transition.downToUp ,
      transitionDuration: Duration(milliseconds: 600),
    ),
    // GetPage(
    //   name: AppRoutes.inventoryDeleteItem,
    //   page: () => OrdersView(),
    //   binding: OrdersBindings(),
    // ),
    GetPage(
      name: AppRoutes.inventoryEditItem,
      page: () => EditItemView(),
      binding: EditItemBindings(),

    ),
    // GetPage(
    //   name: AppRoutes.inventoryCheck,
    //   page: () => OrdersView(),
    //   binding: OrdersBindings(),
    // ),





  ];
}
