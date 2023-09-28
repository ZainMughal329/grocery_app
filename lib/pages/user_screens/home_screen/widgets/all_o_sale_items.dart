import 'package:flutter/material.dart';

class GroceryItemCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String category;
  final int price;
  final int discount;

  GroceryItemCard({
    required this.imageUrl,
    required this.title,
    required this.category,
    required this.price,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network(imageUrl), // Load image from URL
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(category),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Text(
                  '\$${price.toStringAsFixed(2)}', // Format price with 2 decimal places
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(width: 8.0),
                Text(
                  '(\$${discount.toStringAsFixed(2)} off)',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
