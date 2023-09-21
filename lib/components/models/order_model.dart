import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String orderId;
  final String customerId;
  final String customerName;
  final int totalPrice;
  final List<String> items;
  final DateTime dateTime;
  final List<int> itemQty;


  OrderModel({
    required this.orderId,
    required this.customerId,
    required this.customerName,
    required this.totalPrice,
    required this.dateTime,
    required this.items,
    required this.itemQty,
});

  toJson(){
    return {
      'orderId' : orderId,
      'customerId' : customerId,
      'customerName' : customerName,
      'totalPrice' : totalPrice,
      'dateTime' : dateTime,
      'items' : items,
      'itemQty' : itemQty,
    };
  }

  factory OrderModel.fromJson(DocumentSnapshot<Map<String, dynamic>> snapshot){
    final data = snapshot.data()!;
    return OrderModel(
      orderId:  data['orderId'],
      customerId: data['customerId'],
      customerName: data['customerName'],
      totalPrice: data['totalPrice'],
      dateTime: data['dateTime'],
      items: data['items'],
      itemQty: data['itemQty'],
    );


  }




}