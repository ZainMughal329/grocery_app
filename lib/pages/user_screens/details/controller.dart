import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/models/order_model.dart';
import 'package:grocery_app/components/routes/name.dart';
import 'package:grocery_app/pages/user_screens/details/state.dart';

class DetailsController extends GetxController {
  final state = DetailsState();

  DetailsController();

  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  setIsTrue(bool value) {
    state.isTrue.value = value;
  }

  addDataToFirebase(
    final String userName,
    final int totalPrice,
    final String itemName,
    final DateTime dateTime,
    final int itemQty,
    final String itemId,
      final String itemImg,
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
          Get.toNamed(AppRoutes.homeScreen);
        });
      });
    } catch (e) {
      print(
        'Error is : ' + e.toString(),
      );
    }
  }

  // Future<void> updateDocument() async {
  //   try {
  //     await documentReference.update({
  //       'fieldName': 'updatedValue',
  //     });
  //     print('Document updated successfully.');
  //   } catch (e) {
  //     print('Error updating document: $e');
  //   }
  // }

  // updateCountValue()

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
          .doc(auth.currentUser!.uid)
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

  bool isInCart(String itemId) {
    return itemIds.contains(itemId);
  }
}
