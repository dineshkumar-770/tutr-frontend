import 'package:flutter/material.dart';
import 'package:tutr/resources/app_colors.dart';

class CustomSnackbar {
  static void show({required BuildContext context, required String message, required bool isSuccess}) async {
    final snackBar = SnackBar(
      showCloseIcon: false,
      backgroundColor: AppColors.backgroundColor,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 10,
        children: [
          Icon(
            isSuccess ? Icons.check_circle : Icons.info,
            color: AppColors.textColor1,
          ),
          Flexible(
            child: Text(
              message,
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              style: TextStyle(color: AppColors.textColor1),
            ),
          )
        ],
      ),
      dismissDirection: DismissDirection.startToEnd,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
