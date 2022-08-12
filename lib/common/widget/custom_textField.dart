// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:amazon_clone/constants/global_variables.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      controller: controller,
      obscureText: obscureText,
      validator: (val) {},
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black87,
          )),
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: GlobalVariables.secondaryColor,
          ))),
    );
  }
}
