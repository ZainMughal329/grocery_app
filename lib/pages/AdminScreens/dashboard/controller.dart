import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/reuseable/snackbar_widget.dart';
import 'package:grocery_app/pages/AdminScreens/dashboard/state.dart';
import 'package:intl/intl.dart';

class DashBoardController extends GetxController {
  final state = DashBoardState();
  Map<String, double> loadedMap = {};

  Future<void> fetchData() async {


    fetchAllOrdersData();
    fetchPendingOrdersData();
    fetchDeliveredOrdersData();
    fetchCancelledOrdersData();
    fetchDataAndCountOrdersForMonth();
    fetchDataAndCountOrders();
    getChartData();
    // getMaxOrderCount();

    loadedMap.clear();
    updateLoadedMap();
    state.loaded.value = true;
  }

  updateLoadedMap() {
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
    Future.delayed(Duration(seconds: 3), () {
      try {
        fetchData().then((value) {});
      } catch (e) {
        Snackbar.showSnackBar("Error", e.toString());
      }
    });

    try {
      fetchData().then((value) {});
    } catch (e) {
      Snackbar.showSnackBar("Error", e.toString());
    }
  }



  // void fetchOrdersAndConvertToDateTime() async {
  //   // Initialize Firebase (ensure you've set up Firebase in your project)
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //
  //   // Reference to your collection
  //   CollectionReference ordersCollection = firestore.collection('allOrders');
  //
  //   try {
  //     // Get all documents from the collection
  //     QuerySnapshot querySnapshot = await ordersCollection.get();
  //
  //     // List to store converted DateTime objects
  //     List<String> dateTimeList = [];
  //
  //     // Loop through the documents and convert order IDs to DateTime
  //     querySnapshot.docs.forEach((doc) {
  //       // Assuming 'orderId' is the field that contains the timestamp in milliseconds
  //       String timestampMilliseconds = doc['orderId'];
  //
  //       final timeinmili = int.parse(
  //           timestampMilliseconds.toString());
  //       final dtime = DateTime.fromMicrosecondsSinceEpoch(timeinmili);
  //       String formattedDate = DateFormat('dd-MM').format(dtime);
  //       DateTime dateTime = DateFormat('dd-MM').parse(formattedDate);
  //       String dayName = DateFormat('EEEE').format(dateTime);
  //       print('Day name is : ' + dayName);
  //       print('dtime is :' + dtime.toString() );
  //       print('formated date is : '+ formattedDate.toString());
  //       // Convert timestamp to DateTime
  //
  //       // DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestampMilliseconds);
  //
  //       // Add the DateTime object to the list
  //       dateTimeList.add(dayName);
  //     });
  //
  //     // Now, 'dateTimeList' contains all the DateTime objects converted from order IDs
  //     print(dateTimeList);
  //   } catch (e) {
  //     print('Error fetching and converting orders: $e');
  //   }
  // }
  // void fetchDataAndDisplayDayNames() async {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   CollectionReference allOrdersCollection = firestore.collection('allOrders');
  //
  //   try {
  //     QuerySnapshot querySnapshot = await allOrdersCollection.get();
  //
  //     // Loop through the documents and display day names for 'orderId'
  //     querySnapshot.docs.forEach((doc) {
  //       String orderIdStr = doc['orderId'];
  //       int timestampMicroseconds = int.parse(orderIdStr);
  //
  //       // Convert timestamp to DateTime (microseconds since epoch)
  //       DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(timestampMicroseconds);
  //
  //       // Format the DateTime to get the day name
  //       String dayName = DateFormat('EEEE').format(dateTime);
  //
  //       print('Day Name: $dayName');
  //     });
  //   } catch (e) {
  //     print('Error fetching data: $e');
  //   }
  // }

  void fetchDataAndCountOrders() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference allOrdersCollection = firestore.collection('allOrders');

    try {
      DateTime now = DateTime.now();
      DateTime sevenDaysAgo = now.subtract(Duration(days: 7));
      QuerySnapshot querySnapshot = await allOrdersCollection
          .where('orderId',
              isGreaterThanOrEqualTo:
                  sevenDaysAgo.microsecondsSinceEpoch.toString())
          .get();
      if(querySnapshot.docs.isNotEmpty) {
        Map<String, int> counts = {};

        querySnapshot.docs.forEach((doc) {
          String orderIdStr = doc['orderId'];
          int timestampMicroseconds = int.parse(orderIdStr);
          DateTime dateTime =
          DateTime.fromMicrosecondsSinceEpoch(timestampMicroseconds);
          String day = DateFormat('EEEE').format(dateTime);

          // Count orders for each day
          counts[day] = (counts[day] ?? 0) + 1;
        });

        // Update the GetX controller's orderCounts
        state.orderCounts = counts;
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  // {
  // For past week chart

  // void fetchDataAndCountOrdersForPastData() async {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   CollectionReference allOrdersCollection = firestore.collection('allOrders');
  //
  //   try {
  //     DateTime now = DateTime.now();
  //     DateTime lastWeekStart = now.subtract(Duration(days: now.weekday + 7));
  //     DateTime currentWeekStart = now.subtract(Duration(days: now.weekday));
  //
  //     QuerySnapshot lastWeekQuery = await allOrdersCollection
  //         .where('orderId', isGreaterThanOrEqualTo: lastWeekStart.microsecondsSinceEpoch.toString(), isLessThan: currentWeekStart.microsecondsSinceEpoch.toString())
  //         .get();
  //     QuerySnapshot currentWeekQuery = await allOrdersCollection
  //         .where('orderId', isGreaterThanOrEqualTo: currentWeekStart.microsecondsSinceEpoch.toString())
  //         .get();
  //
  //     Map<String, int> lastWeekCounts = {};
  //     Map<String, int> currentWeekCounts = {};
  //
  //     lastWeekQuery.docs.forEach((doc) {
  //       String orderIdStr = doc['orderId'];
  //       int timestampMicroseconds = int.parse(orderIdStr);
  //       DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(timestampMicroseconds);
  //       String day = DateFormat('EEEE').format(dateTime);
  //
  //       // Count orders for each day in the last week
  //       lastWeekCounts[day] = (lastWeekCounts[day] ?? 0) + 1;
  //     });
  //
  //     currentWeekQuery.docs.forEach((doc) {
  //       String orderIdStr = doc['orderId'];
  //       int timestampMicroseconds = int.parse(orderIdStr);
  //       DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(timestampMicroseconds);
  //       String day = DateFormat('EEEE').format(dateTime);
  //
  //       // Count orders for each day in the current week
  //       currentWeekCounts[day] = (currentWeekCounts[day] ?? 0) + 1;
  //     });
  //
  //     // Update the GetX controller's orderCounts
  //     state.lastWeekOrderCounts = lastWeekCounts;
  //     state.currentWeekOrderCounts = currentWeekCounts;
  //
  //   } catch (e) {
  //     print('Error fetching data: $e');
  //   }
  // }

  void fetchDataAndCountOrdersForMonth() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference allOrdersCollection = firestore.collection('allOrders');

    try {
      QuerySnapshot querySnapshot = await allOrdersCollection.get();
      if(querySnapshot.docs.isNotEmpty) {
        Map<String, int> counts = {};

        querySnapshot.docs.forEach((doc) {
          String orderIdStr = doc['orderId'];
          int timestampMicroseconds = int.parse(orderIdStr);
          DateTime dateTime =
          DateTime.fromMicrosecondsSinceEpoch(timestampMicroseconds);
          String month = DateFormat('MMM yyyy').format(dateTime);

          // Count orders for each month
          counts[month] = (counts[month] ?? 0) + 1;
        });

        // Update the GetX controller's orderCounts
        state.monthlySales = counts;
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  List<FlSpot> getChartData() {
    return List.generate(state.months.length, (index) {
      final month = state.months[index];
      final orderCount = state.monthlySales[month] ?? 0;
      return FlSpot(index.toDouble(), orderCount.toDouble());
    });
  }

  // double getMaxOrderCount() {
  //   return state.monthlySales.values
  //       .reduce((max, count) => count > max ? count : max)
  //       .toDouble();
  // }

  void showDataForMonth(int monthIndex) {
    final selectedMonth = state.months[monthIndex];
    final orderCount = state.monthlySales[selectedMonth] ?? 0;
    showDialog(
      context: Get.context!,
      builder: (_) {
        return AlertDialog(
          title: Text('Orders for $selectedMonth'),
          content: Text('Total Orders: $orderCount'),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(Get.context!).pop(),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
