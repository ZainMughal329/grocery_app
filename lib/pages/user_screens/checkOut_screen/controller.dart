import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/models/place_order_model.dart';
import 'package:grocery_app/components/reuseable/snackbar_widget.dart';
import 'package:grocery_app/components/routes/name.dart';
import 'package:grocery_app/components/routes/routes.dart';
import 'package:grocery_app/pages/user_screens/checkOut_screen/state.dart';

class CheckOutController extends GetxController {
  final state = CheckOutState();
  final allOrdersRef = FirebaseFirestore.instance.collection('allOrders');


void setLoading(bool value){
  state.loading.value = value;
}

  Future<void> addOrder (PlaceOrderModel orderData) async{
  setLoading(true);
    final id= DateTime.timestamp().microsecondsSinceEpoch.toString();
    try{
      await allOrdersRef.doc(id).set(orderData.toJson()).then((value){
setLoading(false);
        Snackbar.showSnackBar("Order Placed", "Successfully");
        Get.offNamed(AppRoutes.homeScreen);


      }).onError((error, stackTrace){
        setLoading(false);


        Snackbar.showSnackBar("Error", error.toString());
      });
    }catch(e){
      setLoading(false);
      Snackbar.showSnackBar("Error", e.toString());
    }
  }



}