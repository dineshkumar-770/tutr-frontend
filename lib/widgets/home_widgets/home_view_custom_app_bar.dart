// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:tutr_frontend/constants/app_colors.dart';
import 'package:tutr_frontend/constants/constant_strings.dart';
import 'package:tutr_frontend/core/singletons/shared_prefs.dart';

class HomeViewCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeViewCustomAppBar({
    super.key,
    required this.appBar,
  });
  final AppBar appBar;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      title: Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              Text(
                "Hi, ${Prefs.getString(ConstantStrings.fullName)}",
                style: TextStyle(fontSize: 16, color: AppColors.textColor2, fontWeight: FontWeight.bold),
              ),
              CircleAvatar(
                backgroundColor: AppColors.primaryColor,
                radius: 14,
                child: Text(
                  Prefs.getString(ConstantStrings.fullName)[0].toUpperCase(),
                  style: TextStyle(color: AppColors.textColor3, fontSize: 14),
                ),
              ),
            ],
          )),
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
