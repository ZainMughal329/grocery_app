import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/routes/name.dart';
import 'package:grocery_app/components/routes/routes.dart';
import 'package:grocery_app/components/services/cart_controller_reuseable.dart';
import 'package:grocery_app/components/themes/dark_theme.dart';
import 'package:grocery_app/components/themes/theme_data.dart';
import 'package:grocery_app/pages/user_screens/cart_directory/controller.dart';
import 'package:grocery_app/pages/user_screens/details/controller.dart';
import 'package:grocery_app/pages/user_screens/home_screen/controller.dart';
import 'package:grocery_app/pages/user_screens/profile/controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(MyCartController());
  Get.put(HomeController());

  Get.put(CartControllerReuseAble());

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  DarkThemeChanger darkThemeChanger = DarkThemeChanger();

  void getCurrentAppTheme() async {
    darkThemeChanger.setDarkTheme =
        await darkThemeChanger.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    // TODO: implement initState
    getCurrentAppTheme();
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
          return GetMaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            // theme: Styles.themeData(con.getDarkTheme, context),
            initialRoute: AppRoutes.splashScreen,
            getPages: AppPages.routes,
          );
        },

    );
  }
}
