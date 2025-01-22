import 'package:flutter/cupertino.dart';
import 'package:tutr/resources/app_colors.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator(
      animating: true,
      color: AppColors.buttonTextColor,
      radius: 15,
    );
  }
}
