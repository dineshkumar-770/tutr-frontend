import 'package:flutter/material.dart';
import 'package:tutr_frontend/constants/app_colors.dart';

class DropDownStyle {
  static InputDecoration getDropDownDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: AppColors.grey200,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Padding inside dropdown
    );
  }

  static TextStyle primaryButtonTextStyle() {
    return TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.buttonTextColor);
  }
}
