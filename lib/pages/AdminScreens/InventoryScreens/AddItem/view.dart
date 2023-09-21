import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/colors/light_app_colors.dart';
import 'package:grocery_app/components/reuseable/inventory_input_widget.dart';
import 'package:grocery_app/components/reuseable/round_button.dart';
import 'package:grocery_app/components/reuseable/search_text_field.dart';
import 'package:grocery_app/components/reuseable/text_form_field.dart';
import 'package:grocery_app/components/reuseable/text_widget.dart';
import 'package:grocery_app/pages/AdminScreens/InventoryScreens/AddItem/controller.dart';

class AddItemView extends GetView<AddItemController> {
  AddItemView({Key? key}) : super(key: key);

  final textCont = TextEditingController();

  Widget _buildForm() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Container(
              height: 150.h,
              width: 150.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
                color: LightAppColor.btnColor.withOpacity(0.1),
              ),
            ),
          ),
          InventoryInputWidget(
            title: 'Title',
            iconData: Icons.drive_file_rename_outline,
            controller: controller.state.titleController,
            inputType: TextInputType.text,
          ),
          InventoryInputWidget(
            title: 'Price',
            iconData: Icons.monetization_on_outlined,
            controller: controller.state.priceController,
            inputType: TextInputType.number,
          ),
          InventoryInputWidget(
            title: 'Stock',
            iconData: Icons.inventory_outlined,
            controller: controller.state.stockController,
            inputType: TextInputType.number,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(title: 'Price Quantity'),
                Obx(() {
                  return DropdownButton(
                    hint: TextWidget(
                      title: controller.state.buttonValue.value,
                      fontSize: 14,
                    ),
                    items: [
                      DropdownMenuItem(
                        child: TextWidget(
                          title: 'Item',
                          fontSize: 14,
                        ),
                        value: 'perItem',
                      ),
                      DropdownMenuItem(
                        child: TextWidget(
                          title: 'Kg',
                          fontSize: 14,
                        ),
                        value: 'perKg',
                      ),
                      DropdownMenuItem(
                        child: TextWidget(
                          title: 'Dozen',
                          fontSize: 14,
                        ),
                        value: 'dozen',
                      )
                    ],
                    onChanged: (value) {
                      controller.state.buttonValue.value = value!;
                      // print(DateTime.now().day);
                    },
                  );
                }),
              ],
            ),
          ),
          RoundButton(title: 'Add Product', onPress: () {}),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Inventory"),
        backgroundColor: LightAppColor.btnColor,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 10.h, bottom: 40.h),
            child: _buildForm(),
          ),
        )),
      ),
    );
  }
}
