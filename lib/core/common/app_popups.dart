import 'package:flutter/material.dart';
import 'package:tutr_frontend/constants/app_colors.dart';

class AppPopups {
  Future showGeneralInfoPop(
      {required BuildContext context,
      required double height,
      required String title,
      required List<Widget>? actionButtons,
      required List<Widget> content}) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(color: AppColors.textColor2),
          ),
          actions: actionButtons,
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          content: SizedBox(
            height: height,
            child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: content),
          ),
        );
      },
    );
  }
}
