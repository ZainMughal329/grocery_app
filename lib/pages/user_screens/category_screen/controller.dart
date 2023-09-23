import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:grocery_app/pages/session_sreens/login/index.dart';
import 'package:grocery_app/pages/session_sreens/signup/state.dart';
import 'package:grocery_app/pages/user_screens/category_screen/index.dart';
import 'package:grocery_app/pages/user_screens/home_screen/index.dart';

import '../../../components/models/item_model.dart';
import '../../../components/models/order_model.dart';

class CategoryController extends GetxController {
  final state = CategoryState();

  CategoryController();
  List<Color> gridColors = [
    const Color(0xff53B175),
    const Color(0xffF8A44C),
    const Color(0xffF7A593),
    const Color(0xffD3B0E0),
    const Color(0xffB7DFF5),

  ];

  List<Map<String , dynamic>> catInfo = [
    {
      'imgPath' : 'assets/pic1.jpeg',
      'catText' : 'HouseHold',
    },
    {
      'imgPath' : 'assets/pic2.jpeg',
      'catText' : 'Kitchen',
    },
    {
      'imgPath' : 'assets/pic3.jpeg',
      'catText' : 'Bathroom',
    },
    {
      'imgPath' : 'assets/pic4.jpeg',
      'catText' : 'Clothing',
    },
    {
      'imgPath' : 'assets/pic5.jpeg',
      'catText' : 'Grocery',
    },
  ];

  final List<void Function()> pressButton = [
    () {
    print('1');
    },
        () {
      print('2');
    },
        () {
      print('3');
    },
        () {
      print('4');
    },
        () {
      print('5');
    },
  ];

  final items =
  FirebaseFirestore.instance.collection('Items').snapshots();

  Future<List<ItemModel>> getAllItemsData() async {
    final snapshot =
    await FirebaseFirestore.instance.collection('Items').get();
    final itemData = snapshot.docs.map((e) => ItemModel.fromJson(e)).toList();
    return itemData;
  }

  Future<List<ItemModel>> getAndShowALlItemsData() async {
    return await getAllItemsData();
  }


  Future<void> fetchUsername() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        final fetchedUsername = data['userName'] as String;
        state.username.value = fetchedUsername;
      } else {
        state.username.value =
        'Guest User'; // User not found or document doesn't exist.
      }
    } catch (error) {
      // Handle any potential errors here.
      print('Error fetching username: $error');
    }
  }

  final RxList<String> itemIds = <String>[].obs;

  @override
  void onInit() {
    super.onInit();

    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final collectionReference = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('orderList');
      final QuerySnapshot querySnapshot = await collectionReference.get();

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

  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  addDataToFirebase(
      final String userName,
      final int totalPrice,
      final String itemName,
      final DateTime dateTime,
      final int itemQty,
      final String itemId,
      String itemImg,
      ) async {
    try {
      String timeStamp = DateTime.now().microsecondsSinceEpoch.toString();
      await db
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('orderList')
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
            itemId: itemId, itemImg: itemImg,)
            .toJson(),
      )
          .then((value) async {
        await db
            .collection('allOrdersList')
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
              itemId: itemId, itemImg: itemImg,)
              .toJson(),
        )
            .then((value) {
          print('Added to cart successfully');
        });
      });
    } catch (e) {
      print(
        'Error is : ' + e.toString(),
      );
    }
  }
}