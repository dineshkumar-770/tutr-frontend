import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class CustomToast {
  static show({
    required ToastificationType toastType,
    required BuildContext context,
    required String title,
  }) {
    toastification.show(
        context: context,
        type: toastType,
        style: ToastificationStyle.fillColored,
        autoCloseDuration: const Duration(seconds: 5),
        title: Text("TuTr Says..."),
        description: RichText(text: TextSpan(text: title)),
        alignment: Alignment.topRight,
        direction: TextDirection.ltr,
        animationDuration: const Duration(milliseconds: 300),
        animationBuilder: (context, animation, alignment, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x07000000),
            blurRadius: 16,
            offset: Offset(0, 16),
            spreadRadius: 0,
          )
        ],
        closeOnClick: false,
        pauseOnHover: true,
        dragToClose: true,
        applyBlurEffect: false,
        showProgressBar: false);
  }
}
