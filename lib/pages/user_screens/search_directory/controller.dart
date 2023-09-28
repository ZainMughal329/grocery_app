import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/models/item_model.dart';
import 'package:grocery_app/pages/user_screens/search_directory/state.dart';

class SearchBarController extends GetxController {
  final state = SearchState();
  final auth = FirebaseAuth.instance;

  SearchBarController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxList<DocumentSnapshot> itemData = RxList<DocumentSnapshot>();
  RxList<DocumentSnapshot> filteredItemsList = RxList<DocumentSnapshot>();

  // Initialize the controller and fetch data from Firestore
  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  // Fetch data from Firestore
  void fetchData() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('Items').get();

    print('Snapshot is : ' + querySnapshot.toString());
    itemData.assignAll(querySnapshot.docs);
  }

  // Search for tours based on a query
  void searchTours(String query) {
    final lowerCaseQuery = query.toLowerCase();
    List<DocumentSnapshot> results = [];
    if (query.isEmpty) {
      results = [];
    } else {
      results = itemData
          .where((ele) =>
              ele['title'].toString().toLowerCase().contains(lowerCaseQuery) ||
              ele['category']
                  .toString()
                  .toLowerCase()
                  .contains(lowerCaseQuery) ||
              ele['subCategory']
                  .toString()
                  .toLowerCase()
                  .contains(lowerCaseQuery) ||
              ele['description']
                  .toString()
                  .toLowerCase()
                  .contains(lowerCaseQuery))
          .toList();
    }
    filteredItemsList.value = results;
    update();
  }

  int calculateDiscountedPrice(int originalPrice, int? discountPercentage) {
    // Calculate the discount amount
    int discountAmount = (originalPrice * discountPercentage!) ~/ 100;

    // Calculate the discounted price
    int discountedPrice = originalPrice - discountAmount;

    return discountedPrice;
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
}
