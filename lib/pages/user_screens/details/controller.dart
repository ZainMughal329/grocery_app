import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:grocery_app/components/models/order_model.dart';
import 'package:grocery_app/components/reuseable/snackbar_widget.dart';
import 'package:grocery_app/components/routes/name.dart';
import 'package:grocery_app/components/services/cart_controller_reuseable.dart';
import 'package:grocery_app/pages/user_screens/details/state.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class DetailsController extends GetxController {
  final state = DetailsState();
  final cartCon = Get.find<CartControllerReuseAble>();

  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  setIsTrue(bool value) {
    state.isTrue.value = value;
  }

  addDataToFirebase(final String userName,
      final int totalPrice,
      final String itemName,
      final DateTime dateTime,
      final int itemQty,
      final String itemId,
      final String itemImg,
      final String category,
      final String subCategory,
      final int discount,) async {
    try {
      String timeStamp = DateTime
          .now()
          .microsecondsSinceEpoch
          .toString();
      await db
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('cartList')
          .doc(timeStamp)
          .set(
        OrderModel(
          orderId: timeStamp,
          customerId: auth.currentUser!.uid.toString(),
          customerName: userName,
          totalPrice: totalPrice,
          dateTime: dateTime,
          itemName: itemName,
          itemQty: itemQty,
          itemId: itemId,
          itemImg: itemImg,
          category: category,
          subCategory: subCategory,
          discount: discount,
        ).toJson(),
      )
          .then((value) async {
        Snackbar.showSnackBar('Success', 'Added data to cart successfully');
      });
    } catch (e) {
      print(
        'Error is : ' + e.toString(),
      );
    }
  }

  final RxList<String> itemIds = <String>[].obs;

  @override
  void onInit() {
    super.onInit();

    fetchData();
    fetchWishListData();
  }

  Future<void> fetchData() async {
    try {
      final collectionReference = FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('cartList');
      final QuerySnapshot querySnapshot = await collectionReference.get();
      itemIds.clear();
      for (final QueryDocumentSnapshot document in querySnapshot.docs) {
        final data = document.data() as Map<String, dynamic>;
        final itemId = data["itemId"]
        as String; // Replace 'itemId' with the actual field name

        itemIds.add(itemId);
      }
      print('Items are : ' + itemIds.toString());
    } catch (e) {
      print('Error fetching itemIds: $e');
    }
  }

  bool isInCart(String itemId) {
    return itemIds.contains(itemId);
  }

  int calculateDiscountedPrice(int originalPrice, int? discountPercentage) {
    // Calculate the discount amount
    int discountAmount = (originalPrice * discountPercentage!) ~/ 100;

    // Calculate the discounted price
    int discountedPrice = originalPrice - discountAmount;

    return discountedPrice;
  }

  final RxList<String> itemIdsForWishList = <String>[].obs;

  @override
  Future<void> fetchWishListData() async {
    try {
      final collectionReference = FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('wishList');
      final QuerySnapshot querySnapshot = await collectionReference.get();
      itemIdsForWishList.clear();
      for (final QueryDocumentSnapshot document in querySnapshot.docs) {
        final data = document.data() as Map<String, dynamic>;
        final itemId = data["itemId"]
        as String; // Replace 'itemId' with the actual field name

        itemIdsForWishList.add(itemId);
      }
      print('Items of wishlist are : ' + itemIdsForWishList.toString());
    } catch (e) {
      print('Error fetching itemIds: $e');
    }
  }

  RxString timeStampForWishList = ''.obs;

  addDataToFirebaseInWishList(final String userName,
      final int totalPrice,
      final String itemName,
      // final DateTime dateTime,
      final int itemQty,
      final String itemId,
      final String itemImg,
      final String category,
      final String subCategory,
      final int discount,) async {
    try {
      timeStampForWishList.value = DateTime
          .now()
          .millisecondsSinceEpoch
          .toString();
      await db
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('wishList')
          .doc(itemId)
          .set(
        OrderModel(
          orderId: timeStampForWishList.value,
          customerId: auth.currentUser!.uid.toString(),
          customerName: userName,
          totalPrice: totalPrice,
          // dateTime: dateTime,
          itemName: itemName,
          itemQty: itemQty,
          itemId: itemId,
          itemImg: itemImg,
          category: category,
          subCategory: subCategory,
          discount: discount,
        ).toJson(),
      )
          .then((value) async {
        // Snackbar.showSnackBar('Success', 'Added data to cart successfully');
        print('Added in wishList');
        fetchWishListData();
      });
    } catch (e) {
      print(
        'Error is : ' + e.toString(),
      );
    }
  }

  deleteDataFromWishList(String itemId) async {
    await db
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('wishList')
        .doc(itemId)
        .delete()
        .then((value) {
      print('Remove from wishList');
      // fetchWishListData();
    });
  }

  Future<XFile?> urlToXFile(String imageUrl) async {
    try {
      // Fetch the image data from the internet
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        // Get a temporary directory to save the downloaded image
        final directory = await getTemporaryDirectory();

        // Generate a file path in the temporary directory
        final filePath = (directory.path+'tempImage.jpg');

        // Save the image data to a file
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        // Convert the file to XFile and return
        return XFile(file.path);
      } else {
        print('Failed to load image from the internet');
        return null;
      }
    } catch (e) {
      print('Error converting URL to XFile: $e');
      return null;
    }
  }
  // void shareProduct(String name, String imageUrl) {

    Future<void> shareProduct(String title, String price , String imageUrl) async {

    try {

      XFile? imageFile = await urlToXFile(imageUrl);

      // Share.share('check out my website https://example.com');

      await Share.shareXFiles( [(imageFile!)], text: 'Check Out : '+title + '\nPrice: '+price+' on GrocerZone Application \navailable on GooglePlayStore \nLink: https//:grocerzone.google-play.com ',subject: 'https://link to app');




    }catch(e){



      }





    }





    // final String txt = 'Check out this amazing product: ${name}';
    // final String img = imageUrl;
    // Share.share(txt,subject: 'ProductDetails',sharePositionOrigin: Rect.fromCenter(
    //   center: Offset(0, 0), // Position of the share button
    //   width: 50,
    //   height: 50,
    // ),);


}
