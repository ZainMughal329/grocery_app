import 'package:flutter/material.dart';
import 'package:grocery_app/components/reuseable/text_widget.dart';

class CategoryWidget extends StatelessWidget {
  final String image;
  final String title;
  final Color color;

  const CategoryWidget(
      {super.key,
        required this.title,
        required this.image,
        required this.color});

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        print('pressed');
      },
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withOpacity(0.7),
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: _screenWidth * 0.3,
              width: _screenWidth * 0.3,
              decoration: BoxDecoration(
                image:
                DecorationImage(image: AssetImage(image), fit: BoxFit.fill),
              ),
            ),
            TextWidget(
              title: title,
              textColor: Colors.black,
              fontSize: 20,
            ),
          ],
        ),
      ),
    );
  }
}
