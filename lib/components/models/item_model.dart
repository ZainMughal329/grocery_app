import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_app/components/models/user_model.dart';

class ItemModel {
  String? itemId;
   final String title;

   final int price;
   final String priceQty;
   final int stock;
   final String imageUrl;
   int? discount;

   ItemModel({
    this.itemId ='',
     required this.title,
     required this.price,
     required this.priceQty,
     required this.stock,
     this.imageUrl = '' ,
     this.discount = 0,
});

   toJson(){
     return {
       'id' : itemId,
       'title' : title,
       'price' : price,
       'priceQty' : priceQty,
       'stock' : stock,
       'imageUrl' : imageUrl,
       'discount' :discount,
     };
   }


  factory ItemModel.fromJson(DocumentSnapshot<Map<String, dynamic>> snapshot){
     final data = snapshot.data()!;
     return ItemModel(
       itemId:  data['itemId'],
         title: data['title'],
         price: data['price'],
         priceQty: data['priceQty'],
         stock: data['stock'],
       imageUrl: data['imageUrl'],
       discount: data['discount'],
     );


  }



}