import 'package:get/get.dart';
import 'package:grocery_app/components/services/dark_theme_prefs.dart';

class DarkThemeChanger extends GetxController{
  DarkThemePrefs darkThemePrefs = DarkThemePrefs();
  bool _darkTheme = false;
  bool get getDarkTheme => _darkTheme;

  set setDarkTheme(bool value) {
    _darkTheme = value;
    darkThemePrefs.setDarkTheme(value);
    Future<bool> yourFuture = darkThemePrefs.getTheme();
    yourFuture.then((boolValue) {
      String stringValue = boolValue.toString();
      print('value is : ' + stringValue);
    });

    update();
  }
}