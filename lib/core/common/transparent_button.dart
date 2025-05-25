// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:tutr_frontend/constants/app_colors.dart';

class TransparentButton extends StatelessWidget {
  const TransparentButton({
    super.key,
    this.onTap,
    required this.label,
    required this.icon,
    this.height,
    this.width,
  });
  final void Function()? onTap;
  final String label;
  final IconData icon;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 40,
        width: width,
        decoration: BoxDecoration(
            border: Border.all(
              width: 0.4,
              color: AppColors.primaryColor,
            ),
            borderRadius: BorderRadius.circular(200),
            boxShadow: [
              BoxShadow(blurRadius: 3, blurStyle: BlurStyle.outer, spreadRadius: 0, color: AppColors.primaryColor)
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 5,
              children: [
                Icon(
                  icon,
                  color: AppColors.primaryColor,
                  size: 20,
                ),
                Flexible(
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
