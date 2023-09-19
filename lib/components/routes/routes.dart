// import 'package:air_proj_comp/pages/Administration/login/index.dart';

import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:grocery_app/pages/session_sreens/forgot/index.dart';
import 'package:grocery_app/pages/session_sreens/login/index.dart';
import 'package:grocery_app/pages/session_sreens/signup/bindings.dart';
import 'package:grocery_app/pages/session_sreens/signup/view.dart';
import 'package:grocery_app/pages/user_screens/home_screen/index.dart';

import 'name.dart';

class AppPages {
  // static List<String> history = [];
  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.signUpScreen,
    page: () => const SignInView(),
    binding: SignInBindings(),
    ),

    GetPage(
      name: AppRoutes.logInScreen,
      page: () => const LogInView(),
      binding: LogInBindings(),
    ),
    GetPage(
      name: AppRoutes.homeScreen,
      page: () => HomeView(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: AppRoutes.forgotScreen,
      page: () => const ForgotView(),
      binding: ForgotBindings(),
    ),

  ];
}
