import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/colors/light_app_colors.dart';
import 'package:grocery_app/components/models/place_order_model.dart';
import 'package:grocery_app/components/reuseable/round_button.dart';
import 'package:grocery_app/components/reuseable/snackbar_widget.dart';
import 'package:grocery_app/components/reuseable/text_widget.dart';
import 'package:grocery_app/components/services/session_controller.dart';
import 'package:grocery_app/pages/user_screens/checkOut_screen/controller.dart';

class CheckOutView extends GetView<CheckOutController> {
  int totalPrice ;
  CheckOutView({Key? key,required this.totalPrice}) : super(key: key);
  final controller  = Get.put<CheckOutController>(CheckOutController());

  final _formKey = GlobalKey<FormState>();
  // String paymentMethod = 'Cash on Delivery';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
        backgroundColor: LightAppColor.btnColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller.state.nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: LightAppColor.btnColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: LightAppColor.btnColor),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: controller.state.phoneController,

                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: LightAppColor.btnColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: LightAppColor.btnColor),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: controller.state.addressController,

                  decoration: InputDecoration(
                    labelText: 'Address',
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: LightAppColor.btnColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: LightAppColor.btnColor),
                    ),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),

                SizedBox(height: 16.0),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(title: 'Address Label'),
                      DropdownButton(
                        iconEnabledColor: LightAppColor.btnColor,
                        hint: Text(controller.state.addressLabel.value.toString()),
                          items: controller.state.labelList,
                          onChanged: (value) {
                            controller.state.addressLabel.value = value;
                          },),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
                Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(title: 'Payment Method'),
                          DropdownButton(
                            iconEnabledColor: LightAppColor.btnColor,
                            hint: Text(controller.state.paymentMethod.value.toString()),
                    items: controller.state.paymentList,
                    onChanged: (value) {
                          controller.state.paymentMethod.value = value;
                    },),
                        ],
                      ),
                ),
                SizedBox(height: 16.0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(title: 'Order Price'),
                    TextWidget(title: totalPrice.toString()),
                  ],
                ),
                // DropdownButtonFormField(
                //   value: paymentMethod,
                //   items: [
                //     DropdownMenuItem(
                //         value: 'Cash on Delivery',
                //         child: Text('Cash on Delivery')),
                //     DropdownMenuItem(
                //         value: 'Card Payment', child: Text('Card Payment')),
                //   ],
                //   onChanged: (value) {},
                //   decoration: InputDecoration(labelText: 'Payment Method'),
                // ),
                SizedBox(height: 50.h),
               Obx((){
                 return controller.state.loading.value == true ? Container(child: CircularProgressIndicator(color: LightAppColor.btnColor,)):  RoundButton(
                     title: 'Proceed to Pay', onPress: (){
                   if(_formKey.currentState!.validate()){
                     if(controller.state.addressLabel.value!='Select'&&controller.state.paymentMethod.value!='Select'){
                       final id = SessionController().userId.toString();
                       final orderData = PlaceOrderModel(
                         customerId: id,
                         name: controller.state.nameController.text.trim().toString(),
                         number: controller.state.phoneController.text.trim().toString(),
                         address: controller.state.addressController.text.trim().toString(),
                         addressLabel: controller.state.addressLabel.value.toString(),
                         paymentMethod: controller.state.paymentMethod.value.toString(),
                         orderPrice: totalPrice,
                       );

                       controller.addOrder(orderData);



                     }else{
                       Snackbar.showSnackBar("No", "Not validated");
                     }

                   }else{
                     Snackbar.showSnackBar("No", "Not validated");
                   }
                 });
               }),

                // ElevatedButton(
                //   style: ButtonStyle(
                //     backgroundColor:
                //         MaterialStateProperty.all(LightAppColor.btnColor),
                //   ),
                //   onPressed: () {
                //     if (_formKey.currentState!.validate()) {
                //       // Proceed with the checkout process
                //     }
                //   },
                //   child: Text('Proceed to Pay'),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
