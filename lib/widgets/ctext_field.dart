// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class CostomTextField extends StatelessWidget {
  final String labText;
  final TextEditingController controller;
  final TextInputType keyboardType;

// ignore: use_key_in_widget_constructors
  CostomTextField(
      {required this.labText,
      required this.keyboardType,
      required this.controller});
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labText,
      ),
    );
  }
}
