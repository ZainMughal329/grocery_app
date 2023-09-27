import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/reuseable/snackbar_widget.dart';
import 'package:grocery_app/pages/AdminScreens/dashboard/state.dart';

class DashBoardController extends GetxController {
  final state = DashBoardState();
  Map<String, double> loadedMap ={};

  Future<void> fetchData() async {
    fetchAllOrdersData();
    fetchPendingOrdersData();
    fetchDeliveredOrdersData();
    fetchCancelledOrdersData();
    loadedMap.clear();
    updateLoadedMap();
    state.loaded.value = true;
  }

  updateLoadedMap(){
    loadedMap = {
      "Orders": state.totalOrders.toDouble(),
      "Pending": state.pendingOrders.toDouble(),
      "Delivered": state.deliveredOrders.toDouble(),
      "Cancelled": state.cancelledOrders.toDouble(),
    };
  }

  Future<void> fetchPendingOrdersData() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('allOrders')
        .where('status', isEqualTo: 'pending')
        .get();

    if (snapshot.docs.isNotEmpty) {
      state.pendingOrders = snapshot.docs.length;
      // loadedMap.addAll(
      //     {"Pending": state.pendingOrders.toDouble()}
      // );
    }
  }
  Future<void> fetchDeliveredOrdersData() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('allOrders')
        .where('status', isEqualTo: 'delivered')
        .get();

    if (snapshot.docs.isNotEmpty) {
      state.deliveredOrders = snapshot.docs.length;
      // loadedMap.addAll({"Delivered": state.deliveredOrders.toDouble()});
    }
  }
  Future<void> fetchCancelledOrdersData() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('allOrders')
        .where('status', isEqualTo: 'cancelled')
        .get();

    if (snapshot.docs.isNotEmpty) {
      state.cancelledOrders = snapshot.docs.length;
      // loadedMap.addAll({"Cancelled": state.cancelledOrders.toDouble()});
    }
  }

  Future<void> fetchAllOrdersData() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('allOrders').get();
    int totalOrderAmount = 0;
    if (snapshot.docs.isNotEmpty) {
      state.totalOrders = snapshot.docs.length;
      // loadedMap.addAll({"Orders": state.totalOrders.toDouble()});
      for (DocumentSnapshot doc in snapshot.docs) {
        int orderPrice = doc['orderPrice'];
        totalOrderAmount = totalOrderAmount + orderPrice;
      }
      state.totalSales = totalOrderAmount;
    }
  }

  Future<void> refreshData() async {
    state.loaded.value = false;
    Snackbar.showSnackBar("Updating", "Fetching data...");
    Future.delayed(Duration(seconds: 3),(){
      try{
        fetchData().then((value){

        });
      }catch(e){
        Snackbar.showSnackBar("Error", e.toString());
      }
    });

    try{
      fetchData().then((value){

      });
    }catch(e){
      Snackbar.showSnackBar("Error", e.toString());
    }

  }
}
