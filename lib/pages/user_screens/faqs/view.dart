import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/colors/light_app_colors.dart';
import 'package:grocery_app/components/reuseable/icon_widget.dart';
import 'package:grocery_app/components/reuseable/text_widget.dart';
import 'package:grocery_app/components/routes/name.dart';
import 'package:grocery_app/pages/user_screens/faqs/controller.dart';

class FAQScreen extends GetView<FAQSController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          title: 'FAQs',
          fontSize: 18.sp,

        ),
        leading: IconButton(
          onPressed: () {
            Get.offAndToNamed(AppRoutes.homeScreen);
          },
          icon: IconWidget(
            iconData: Icons.arrow_back,
          ),
        ),
        backgroundColor: LightAppColor.bgColor,
      ),
      body: ListView.builder(
        itemCount: controller.faqs.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ExpansionTile(
                title: TextWidget(
                  title: controller.faqs[index].question,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextWidget(title: "  " + controller.faqs[index].answer),
                  ),
                ],
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }
}

class FAQItem {
  final String question;
  final String answer;

  FAQItem({
    required this.question,
    required this.answer,
  });
}
