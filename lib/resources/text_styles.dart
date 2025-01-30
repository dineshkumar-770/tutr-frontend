import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutr/resources/app_colors.dart';

class CustomTextStylesAndDecorations {
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
    return GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.buttonTextColor);
  }
}
