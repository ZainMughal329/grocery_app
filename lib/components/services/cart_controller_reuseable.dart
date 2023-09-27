import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartControllerReuseAble extends GetxController {
  var totalPrice = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadCartItemCount();
    print('price is :' + totalPrice.value.toString());
    fetchUsername();
  }



  addTotalPrice(int price) {
    totalPrice.value = totalPrice.value + price;
    saveCartItemCount(totalPrice.value);
  }

  removeFromTotalPrice(int price) {

      totalPrice.value = totalPrice.value - price;
      saveCartItemCount(totalPrice.value);


  }

  Future<void> loadCartItemCount() async {
    final prefs = await SharedPreferences.getInstance();
    totalPrice.value = prefs.getInt('totalPrice') ?? 0;




  }

  Future<void> saveCartItemCount(int price) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('totalPrice', price);

  }


  void updateTotalPrice(int newPrice) {
    totalPrice.value = newPrice;

    // Update the total price in SharedPreferences
    saveCartItemCount(newPrice);
  }


  int calculateDiscountedPrice(int originalPrice, int? discountPercentage) {
    // Calculate the discount amount
    int discountAmount = (originalPrice * discountPercentage!) ~/ 100;

    // Calculate the discounted price
    int discountedPrice = originalPrice - discountAmount;

    return discountedPrice;
  }
  RxString username = RxString('');

  // Function to fetch the username of a specific user.
  Future<void> fetchUsername() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        final fetchedUsername = data['userName'] as String;
        username.value = fetchedUsername;
      } else {
        username.value =
        'Guest User'; // User not found or document doesn't exist.
      }
    } catch (error) {
      // Handle any potential errors here.
      print('Error fetching username: $error');
    }
  }


}
