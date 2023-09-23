import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartControllerReuseAble extends GetxController {
  var cartItemCount = 0.obs;
  var totalPrice = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadCartItemCount();
  }

  addToCart() {
    cartItemCount.value++;
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
    return totalPrice.value;
  }

  removeFromTotalPrice(int price) {
    if (cartItemCount.value > 0) {
      totalPrice.value = totalPrice.value - price;
      saveCartItemCount();
      return totalPrice.value;

    }
  }

  Future<void> loadCartItemCount() async {
    final prefs = await SharedPreferences.getInstance();
    cartItemCount.value = prefs.getInt('cartItemCount') ?? 0;
    totalPrice.value = prefs.getInt('totalPrice') ?? 0;
  }

  Future<void> saveCartItemCount() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('cartItemCount', cartItemCount.value);
    await prefs.setInt('totalPrice', totalPrice.value);
  }
}
