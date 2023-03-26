import 'package:flutter/material.dart';
import '../../../resources/color_manager.dart';

InputDecoration customTextFormField(String myString) {
  return InputDecoration(
    fillColor: Colors.white,
      filled: true,
      labelText: myString,
      labelStyle: const TextStyle(
          fontSize: 14.0, color: Colors.black54, fontWeight: FontWeight.normal
      ),
      // Set border for enabled state (default)
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: Colors.grey[400]!),
        borderRadius: BorderRadius.circular(5),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: Colors.grey[400]!),
        borderRadius: BorderRadius.circular(5),
      ),
      // Set border for focused state
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: ColorManager.themeBlueColor),
        borderRadius: BorderRadius.circular(5),
      ));
}

InputDecoration dropdownDecorator() {
  return InputDecoration(
    fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey[400]!, width: 1.0)
    ),
    isDense: true,
  );
}