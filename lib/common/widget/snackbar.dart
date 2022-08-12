import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text, handler) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
    behavior: SnackBarBehavior.floating,
    backgroundColor: handler ? Colors.green : Colors.red,
  ));
}
