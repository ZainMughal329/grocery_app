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
import 'package:grocery_app/pages/AdminScreens/InventoryScreens/EditScreen/bindings.dart';
import 'package:grocery_app/pages/AdminScreens/InventoryScreens/EditScreen/view.dart';
import 'package:grocery_app/pages/AdminScreens/dashboard/bindings.dart';
import 'package:grocery_app/pages/AdminScreens/dashboard/view.dart';
import 'package:grocery_app/pages/AdminScreens/orders/OrderDetail/bindings.dart';
import 'package:grocery_app/pages/AdminScreens/orders/OrderDetail/view.dart';
import 'package:grocery_app/pages/AdminScreens/orders/OrderHome/bindings.dart';
import 'package:grocery_app/pages/AdminScreens/orders/OrderItems/bindings.dart';
import 'package:grocery_app/pages/AdminScreens/orders/OrderItems/view.dart';
import 'package:grocery_app/pages/AdminScreens/orders/allOrders/bindings.dart';
import 'package:grocery_app/pages/AdminScreens/orders/allOrders/view.dart';
// import 'package:grocery_app/pages/AdminScreens/orders/view.dart';
import 'package:grocery_app/pages/session_sreens/forgot/index.dart';
import 'package:grocery_app/pages/session_sreens/login/index.dart';
import 'package:grocery_app/pages/session_sreens/signup/bindings.dart';
import 'package:grocery_app/pages/session_sreens/signup/view.dart';
import 'package:grocery_app/pages/session_sreens/splash/bindings.dart';
import 'package:grocery_app/pages/user_screens/all_products_view/bindings.dart';
import 'package:grocery_app/pages/user_screens/all_products_view/view.dart';
import 'package:grocery_app/pages/user_screens/cart_directory/index.dart';
import 'package:grocery_app/pages/user_screens/category_screen/index.dart';
import 'package:grocery_app/pages/user_screens/checkOut_screen/bindings.dart';
import 'package:grocery_app/pages/user_screens/checkOut_screen/view.dart';
import 'package:grocery_app/pages/user_screens/details/bindings.dart';
import 'package:grocery_app/pages/user_screens/details/details.dart';
import 'package:grocery_app/pages/user_screens/faqs/bindings.dart';
import 'package:grocery_app/pages/user_screens/home_screen/index.dart';
import 'package:grocery_app/pages/user_screens/order_view/index.dart';
import 'package:grocery_app/pages/user_screens/profile/index.dart';
import 'package:grocery_app/pages/user_screens/wishList_screen/index.dart';

import '../../pages/session_sreens/splash/view.dart';
import '../../pages/user_screens/faqs/view.dart';
import '../../pages/user_screens/help_center/index.dart';
import 'name.dart';

class AppPages {
  // static List<String> history = [];
  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.splashScreen,
      page: () => const SplashView(),
      binding: SplashScreenBindings(),
    ),

    GetPage(
      name: AppRoutes.signUpScreen,
      page: () => SignInView(),
      binding: SignInBindings(),
    ),

    GetPage(
      name: AppRoutes.logInScreen,
      page: () => LogInView(),
      binding: LogInBindings(),
    ),
    GetPage(
      name: AppRoutes.homeScreen,
      page: () => HomeView(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: AppRoutes.forgotScreen,
      page: () => ForgotView(),
      binding: ForgotBindings(),
    ),

    GetPage(
      name: AppRoutes.faqsScreen,
      page: () => FAQScreen(),
      binding: FAQSBindings(),
    ),

    GetPage(
      name: AppRoutes.helpCenterScreen,
      page: () => HelpCenterScreen(),
      binding: HelpCenterBindings(),
    ),

    GetPage(
      name: AppRoutes.categoryScreen,
      page: () => CategoryView(),
      binding: CategoryBindings(),
    ),

    GetPage(
      name: AppRoutes.categoryScreen,
      page: () => CategoryView(),
      binding: CategoryBindings(),
    ),

    GetPage(
      name: AppRoutes.cartScreen,
      page: () => MyCartScreen(),
      binding: MyCartBindings(),
    ),

    GetPage(
      name: AppRoutes.wishListScreen,
      page: () => WishListScreen(),
      binding: WishListBindings(),
    ),

    GetPage(
      name: AppRoutes.orderScreen,
      page: () => OrderScreen(),
      binding: OrderBindings(),
    ),

    GetPage(
      name: AppRoutes.profileScreen,
      page: () => ProfileView(),
      binding: ProfileBindings(),
    ),


    GetPage(
      name: AppRoutes.checkOutScreen,
      page: () => CheckOutView(totalPrice: 0,timeStamp: '',),
      binding: CheckOutBindings(),
    ),

    GetPage(
      name: AppRoutes.detailsScreen,
      page: () => DetailsScreen(
        title: '',
        itemImg: '',
        price: 0,
        itemQty: '',
        userName: '',
        itemId: '',
        category: '',
        subCategory: '',
        discount: 0,
      ),
      binding: DetailsBinding(),
    ),

    GetPage(
      name: AppRoutes.allProductsScreen,
      page: () => AllProductsScreen(category: '', subCategory: ''),
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
        OrderHomeBindings(),
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
      transition: Transition.downToUp,
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
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 600),
    ),
    GetPage(
      name: AppRoutes.inventoryEdit,
      page: () => EditScreenView(id: ''),
      binding: EditScreenBindings(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 600),
    ),

    GetPage(
      name: AppRoutes.allOrders,
      page: () => OrdersView(),
      binding: OrdersBindings(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 500),
    ),

    GetPage(
      name: AppRoutes.orderDetail,
      page: () => OrderDetailView(orderId: ''),
      binding: OrderDetailsBindings(),
      transition: Transition.leftToRight,
      transitionDuration: Duration(milliseconds: 600),
    ),
    GetPage(
      name: AppRoutes.orderItems,
      page: () => OrderItemsView(customerId: '',orderId: ''),
      binding: OrderItemsBindings(),
      transition: Transition.leftToRight,
      transitionDuration: Duration(milliseconds: 600),
    ),

    // GetPage(
    //   name: AppRoutes.inventoryCheck,
    //   page: () => OrdersView(),
    //   binding: OrdersBindings(),
    // ),
  ];
}
