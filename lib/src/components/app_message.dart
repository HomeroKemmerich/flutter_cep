 import 'package:flutter/material.dart';

AppMessage(BuildContext context, String title, Color backgroundColor) {
   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(title),
    backgroundColor: backgroundColor,
    duration: const Duration(
      seconds: 3
    ),
   ));
}