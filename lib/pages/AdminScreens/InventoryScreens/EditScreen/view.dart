import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/colors/light_app_colors.dart';
import 'package:grocery_app/components/reuseable/profile_text_field.dart';
import 'package:grocery_app/components/reuseable/round_button.dart';
import 'package:grocery_app/components/reuseable/text_widget.dart';
import 'package:grocery_app/pages/AdminScreens/InventoryScreens/EditScreen/controller.dart';

class EditScreenView extends GetView<EditScreenController> {
  String id;
  EditScreenView({Key? key, required this.id}) : super(key: key);
  final controller = Get.put<EditScreenController>(EditScreenController());

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
          Obx(() {
            return controller.state.loading == true
                ? Container(
                    child: Center(
                    child: CircularProgressIndicator(
                      color: LightAppColor.btnColor,
                    ),
                  ))
                : _buildUpdateButton();
          })
        ],
      ),
    );
  }

  Widget _buildUpdateButton() {
    return RoundButton(
        title: 'Update',
        onPress: () {
          controller.updateData(id);
        });
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

  Widget _buildItemImageWidget() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10.h, bottom: 1),
          child: GetBuilder<EditScreenController>(
            builder: (EditScreenController) => Column(
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
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          color: LightAppColor.btnColor.withOpacity(0.1),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: controller.Image == null
                              ? Image(
                                  image:
                                      NetworkImage(controller.state.imageUrl),
                                )
                              : Image.file(
                                  File(controller.Image!.path),
                                  fit: BoxFit.fill,
                                ),
                        )),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                controller.state.imageUrl != ''
                    ? InkWell(
                        onTap: () {
                          controller.pickImageFromGallery();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextWidget(
                              title: 'EditImage',
                              fontSize: 14,
                            ),
                            Icon(
                              Icons.edit,
                              size: 18,
                              color: LightAppColor.btnColor,
                            )
                          ],
                        ),
                      )
                    : Container(),
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
    controller.fetchItem(id);
    return Scaffold(
      backgroundColor: LightAppColor.bgColor,
      appBar: AppBar(
        title: Text('Item Detail'),
        backgroundColor: LightAppColor.btnColor,
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          if (controller.state.loaded.value == false) {
            return Center(child: CircularProgressIndicator());
          } else {
            return _buildForm();
          }
        }),
      ),
    );
  }
}
