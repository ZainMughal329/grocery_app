import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartControllerReuseAble extends GetxController {
  var cartItemCount = 0.obs;
  var totalPrice = 0.obs;
  var isTrue = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadCartItemCount();
  }

  addToCart() {
    cartItemCount.value++;
    saveCartItemCount();
  }
  setToTrue(){
    isTrue.value = true;
    saveCartItemCount();
  }

  removeFromCart() {
    if (cartItemCount.value > 0) {
      cartItemCount.value--;
      saveCartItemCount();
    }
  }

  addTotalPrice(int price) {
    totalPrice.value = totalPrice.value + price;
    saveCartItemCount();
  }

  removeFromTotalPrice(int price) {
    if (cartItemCount.value > 0) {
      totalPrice.value = totalPrice.value - price;
      saveCartItemCount();

    }
  }

  Future<void> loadCartItemCount() async {
    final prefs = await SharedPreferences.getInstance();
    cartItemCount.value = prefs.getInt('cartItemCount') ?? 0;
    totalPrice.value = prefs.getInt('totalPrice') ?? 0;
    isTrue.value = prefs.getBool('isTrue') ?? false;


  }

  Future<void> saveCartItemCount() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('cartItemCount', cartItemCount.value);
    await prefs.setInt('totalPrice', totalPrice.value);
    await prefs.setBool('isTrue', isTrue.value);

  }


}
