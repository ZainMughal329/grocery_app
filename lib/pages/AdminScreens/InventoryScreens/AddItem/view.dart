import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/colors/light_app_colors.dart';
import 'package:grocery_app/components/models/item_model.dart';
import 'package:grocery_app/components/reuseable/inventory_input_widget.dart';
import 'package:grocery_app/components/reuseable/profile_text_field.dart';
import 'package:grocery_app/components/reuseable/round_button.dart';
import 'package:grocery_app/components/reuseable/search_text_field.dart';
import 'package:grocery_app/components/reuseable/snackbar_widget.dart';
import 'package:grocery_app/components/reuseable/text_form_field.dart';
import 'package:grocery_app/components/reuseable/text_widget.dart';
import 'package:grocery_app/components/routes/name.dart';
import 'package:grocery_app/pages/AdminScreens/InventoryScreens/AddItem/controller.dart';

class AddItemView extends GetView<AddItemController> {
  AddItemView({Key? key}) : super(key: key);

  Widget _buildForm() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildItemImageWidget(),
          ProfileInputTextField(
            contr: controller.state.titleController,
            descrip: 'Title',
            obsecure: false,
            icon: Icons.drive_file_rename_outline,
            labelText: 'Title',
            readOnly: false,
          ),
          ProfileInputTextField(
            contr: controller.state.descriptionController,
            descrip: 'Description',
            obsecure: false,
            icon: Icons.insert_drive_file_outlined,
            labelText: 'Description',
            readOnly: false,
          ),
          ProfileInputTextField(
            contr: controller.state.stockController,
            descrip: 'Stock',
            obsecure: false,
            icon: Icons.inventory_rounded,
            labelText: 'Stock',
            readOnly: false,
            keyboardType: TextInputType.number,
          ),
          ProfileInputTextField(
            contr: controller.state.priceController,
            descrip: 'Price',
            obsecure: false,
            icon: Icons.price_check,
            labelText: 'Price',
            readOnly: false,
            keyboardType: TextInputType.number,
          ),
          ProfileInputTextField(
            contr: controller.state.discountController,
            descrip: 'Discount %',
            obsecure: false,
            icon: Icons.percent,
            labelText: 'Discount %',
            readOnly: false,
            keyboardType: TextInputType.number,
          ),
          _buildPriceQtyWidget(),
          _buildCategoryWidget(),
          _buildSubCategoryWidget(),
          Obx((){
            return Container(
              child: controller.state.loading.value == false ? RoundButton(title: 'Add Product', onPress: () {

                if(
                controller.Image!=null &&
                    controller.state.titleController.text!=''&&controller.state.descriptionController.text!=''
                    &&controller.state.stockController.text!=''&&
                    controller.state.priceController.text!=''&&controller.state.discountController.text!=''
                    &&controller.state.priceQtyValue.value!='Select'&&
                    controller.state.categoryValue.value!='Select'&&controller.state.subCategoryValue.value!='Select'
                ){

                  ItemModel item = ItemModel(
                    title: controller.state.titleController.text.trim().toString(),
                    description: controller.state.titleController.text.trim().toString(),
                    price: int.parse(controller.state.priceController.text.trim().toString()),
                    priceQty: controller.state.priceQtyValue.value.toString(),
                    stock: int.parse(controller.state.stockController.text.trim().toString()),
                    category: controller.state.categoryValue.value.toString(),
                    subCategory: controller.state.subCategoryValue.value.toString(),
                    discount: int.parse(controller.state.discountController.text.trim().toString()),

                  );
                  controller.addItem(item);


                }else{
                  Snackbar.showSnackBar('Error', 'Enter All Fields');
                }
              }) : Container(child: Center(child: CircularProgressIndicator(color: LightAppColor.btnColor,))),
            );
          })
        ],
      ),
    );
  }

  Widget _buildPriceQtyWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(
            title: 'Price Quantity',
            textColor: LightAppColor.borderColor,
          ),
          Obx(() {
            return DropdownButton(
              hint: TextWidget(
                title: controller.state.priceQtyValue.value,
                fontSize: 14,
              ),
              items: [
                DropdownMenuItem(
                  child: TextWidget(
                    title: 'Item',
                    fontSize: 14,
                  ),
                  value: 'Item',
                ),
                DropdownMenuItem(
                  child: TextWidget(
                    title: 'Kg',
                    fontSize: 14,
                  ),
                  value: 'Kg',
                ),
                DropdownMenuItem(
                  child: TextWidget(
                    title: 'Dozen',
                    fontSize: 14,
                  ),
                  value: 'Dozen',
                )
              ],
              onChanged: (value) {
                controller.state.priceQtyValue.value = value!;
                // print(DateTime.now().day);
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCategoryWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(
            title: 'Category',
            textColor: LightAppColor.borderColor,
          ),
          Obx(() {
            return DropdownButton(
              style: TextStyle(
                fontSize: 14,
                color: LightAppColor.borderColor,
              ),
              hint: TextWidget(
                title: controller.state.categoryValue.value,
                fontSize: 14,
              ),
              items: [
                DropdownMenuItem(
                  child: TextWidget(
                    title: 'Kitchen',
                    fontSize: 14,
                  ),
                  value: 'Kitchen',
                ),
                DropdownMenuItem(
                  child: TextWidget(
                    title: 'Bathroom',
                    fontSize: 14,
                  ),
                  value: 'Bathroom',
                ),
                DropdownMenuItem(
                  child: TextWidget(
                    title: 'Grocery',
                    fontSize: 14,
                  ),
                  value: 'Grocery',
                ),
                DropdownMenuItem(
                  child: TextWidget(
                    title: 'HouseHold',
                    fontSize: 14,
                  ),
                  value: 'HouseHold',
                ),
                DropdownMenuItem(
                  child: TextWidget(
                    title: 'Clothing',
                    fontSize: 14,
                  ),
                  value: 'Clothing',
                )
              ],
              onChanged: (value) {
                controller.state.categoryValue.value = value!;
                controller.state.subCategoryValue.value = 'Select';
                // print(DateTime.now().day);
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSubCategoryWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(
            title: 'Sub-Category',
            textColor: LightAppColor.borderColor,
          ),
          Obx(() {
            return DropdownButton(
              style: TextStyle(
                fontSize: 14,
                color: LightAppColor.borderColor,
              ),
              hint: TextWidget(
                title: controller.state.subCategoryValue.value,
                fontSize: 14,
              ),
              items:
                  controller.subCatList(controller.state.categoryValue.value),
              onChanged: (value) {
                controller.state.subCategoryValue.value = value!;
                // print(DateTime.now().day);
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _buildItemImageWidget() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10.h, bottom: 1),
          child: GetBuilder<AddItemController>(
            builder: (AddItemController) => Column(
              children: [
                Container(
                  height: 150.h,
                  width: 150.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    color: LightAppColor.btnColor.withOpacity(0.1),
                  ),
                  child: InkWell(
                    onTap: () {
                      controller.pickImageFromGallery();
                    },
                    child: controller.Image == null
                        ? Icon(
                            Icons.image,
                            size: 50,
                            color: LightAppColor.btnColor,
                          )
                        : Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(200),
                              color: LightAppColor.btnColor.withOpacity(0.1),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.file(
                                File(controller.Image!.path),
                                fit: BoxFit.fill,
                              ),
                            )),
                  ),
                ),
                SizedBox(height: 3.h,),
                controller.Image!=null ? InkWell(
                  onTap: (){
                    controller.pickImageFromGallery();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextWidget(title: 'EditImage',fontSize: 14,),
                      Icon(Icons.edit,size: 18,color: LightAppColor.btnColor,)
                    ],
                  ),
                ) : InkWell(
                  onTap: (){
                    controller.pickImageFromGallery();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextWidget(title: 'AddImage',fontSize: 14,),
                      Icon(Icons.add,size: 18,color: LightAppColor.btnColor,)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Container(
        //   child: TextButton(
        //     onPressed: () {
        //       controller.pickImageFromGallery();
        //     },
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         TextWidget(
        //           title: 'Add Image',
        //           fontSize: 14,
        //         ),
        //         Icon(
        //           Icons.add,
        //           color: LightAppColor.btnColor,
        //           size: 18,
        //         )
        //       ],
        //     ),
        //   ),
        // )
      ],
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
