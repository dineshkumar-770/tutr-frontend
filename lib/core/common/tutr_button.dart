// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:tutr_frontend/constants/app_colors.dart';

class TutrPrimaryButton extends StatelessWidget {
  const TutrPrimaryButton({
    super.key,
    required this.onPressed,
    this.icon,
    required this.label,
    this.height,
    this.width,
    this.fontSize,
  });
  final void Function() onPressed;
  final Widget? icon;
  final String label;
  final double? height;
  final double? width;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.maxFinite,
      height: height ?? 45,
      child: ElevatedButton.icon(
          onPressed: onPressed,
          style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(AppColors.primaryButtonColor)),
          label: Center(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.buttonTextColor, fontSize: fontSize ?? 16),
            ),
          ),
          icon: icon),
    );
  }
}
