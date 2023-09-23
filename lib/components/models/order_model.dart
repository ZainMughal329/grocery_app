import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String orderId;
  final String customerId;
  final String customerName;
  final int totalPrice;
  final String itemId;
  final String itemName;
  final DateTime dateTime;
  final int itemQty;
  final String itemImg;


  OrderModel({
    required this.orderId,
    required this.customerId,
    required this.customerName,
    required this.totalPrice,
    required this.itemId,
    required this.dateTime,
    required this.itemName,
    required this.itemQty,
    required this.itemImg,
});

  toJson(){
    return {
      'orderId' : orderId,
      'customerId' : customerId,
      'customerName' : customerName,
      'totalPrice' : totalPrice,
      'itemId' :itemId,
      'dateTime' : dateTime,
      'items' : itemName,
      'itemQty' : itemQty,
      'itemImg' : itemImg,
    };
  }

  factory OrderModel.fromJson(DocumentSnapshot<Map<String, dynamic>> snapshot){
    final data = snapshot.data()!;
    return OrderModel(
      orderId:  data['orderId'],
      customerId: data['customerId'],
      customerName: data['customerName'],
      totalPrice: data['totalPrice'],
      itemId : data['itemId'],
      dateTime: data['dateTime'],
      itemName: data['items'],
      itemQty: data['itemQty'],
        itemImg : data['itemImg'],
    );


  }




}