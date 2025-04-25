// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:tutr_frontend/constants/app_colors.dart';

class CreateGroupWidget extends StatelessWidget {
  const CreateGroupWidget({
    super.key,
    this.onTap,
  });
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            border: Border.all(
              width: 0.4,
              color: AppColors.primaryColor,
            ),
            borderRadius: BorderRadius.circular(200),
            boxShadow: [
              BoxShadow(blurRadius: 3, blurStyle: BlurStyle.outer, spreadRadius: 0, color: AppColors.primaryColor)
            ]),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 5,
            children: [
              Icon(
                Icons.add,
                color: AppColors.primaryColor,
                size: 20,
              ),
              Text(
                "Create Group",
                style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }
}
