import 'dart:ui';

import 'package:get/get.dart';
import 'package:grocery_app/pages/session_sreens/login/index.dart';
import 'package:grocery_app/pages/session_sreens/signup/state.dart';
import 'package:grocery_app/pages/user_screens/category_screen/index.dart';
import 'package:grocery_app/pages/user_screens/faqs/index.dart';
import 'package:grocery_app/pages/user_screens/home_screen/index.dart';

class FAQSController extends GetxController {
  final state = FAQSState();

  FAQSController();

  final List<FAQItem> faqs = [
    FAQItem(
      question: 'How can I place an order for groceries?',
      answer:
          'You can place an order by downloading our app, selecting the items you need, adding them to your cart, and proceeding to checkout.',
    ),

    FAQItem(
        question: 'How can I create an account or sign in to the app?',
        answer:
            'To create an account, open the app and tap on the "Sign Up" or "Register" button. To sign in, use your registered email and password.'),
    FAQItem(question: 'Is my personal information and payment data secure?', answer: 'Yes, we take data security seriously. Our app uses encryption to protect your personal information and payment data. We do not share your information with third parties.'),
    FAQItem(question: 'Can I add items to my cart and complete the purchase later?', answer: 'Absolutely! You can add items to your cart and complete the purchase at your convenience. Your cart contents are saved for your next visit.'),
    FAQItem(question: 'How do I find specific items or products in the app?', answer: 'You can use the search bar at the top of the app to search for specific items or browse through categories and sections to find what you need.'),

  ];
}
