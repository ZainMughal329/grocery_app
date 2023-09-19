import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/reuseable/icon_widget.dart';
import 'package:grocery_app/components/reuseable/profile_text_field.dart';
import 'package:grocery_app/components/routes/name.dart';
import 'package:grocery_app/pages/user_screens/profile/update.dart';

import '../../../components/colors/light_app_colors.dart';
import '../../../components/reuseable/text_widget.dart';
import 'index.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightAppColor.bgColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.offAndToNamed(AppRoutes.homeScreen);
          },
          icon: IconWidget(iconData: Icons.arrow_back),
        ),
        title: TextWidget(
          title: 'My Profile',
          fontSize: 18.sp,
        ),
        backgroundColor: LightAppColor.bgColor,
        actions: [
          SizedBox(
            width: 5.w,
          ),
          TextButton(
            onPressed: () {
              Get.to(() => UpdateView());
            },
            child: TextWidget(
              title: 'Edit',
              textColor: LightAppColor.btnColor,
              fontSize: 18.sp,
            ),
          ),
        ],
        // elevation: 0,
      ),
      body: SingleChildScrollView(
          child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final name = TextEditingController(
                text: snapshot.data!['userName'].toString().capitalizeFirst);
            final email =
                TextEditingController(text: snapshot.data!['email'].toString());
            final phone =
                TextEditingController(text: snapshot.data!['phone'].toString());
            final gender = TextEditingController();

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
              child: Column(
                children: [

                  ProfileInputTextField(
                    contr: name,
                    descrip: 'UserName',
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    obsecure: false,
                    icon: Icons.person,
                    labelText: 'Name',
                    readOnly: true,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  ProfileInputTextField(
                    contr: email,
                    descrip: 'Email',
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    obsecure: false,
                    icon: Icons.email_outlined,
                    labelText: 'Email',
                    readOnly: true,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  ProfileInputTextField(
                    contr: phone,
                    descrip: 'PhoneNo',
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    obsecure: false,
                    icon: Icons.phone,
                    labelText: 'PhoneNo',
                    readOnly: true,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  ProfileInputTextField(
                    contr: gender,
                    descrip: 'Gender',
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    obsecure: false,
                    icon: Icons.people_outline,
                    labelText: 'Gender',
                    readOnly: true,
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: CircularProgressIndicator(
                color: LightAppColor.btnColor,
              ),
            );
          } else {
            return Container();
          }
        },
        stream: controller.getUserData(),
      )),
    );
  }
}
