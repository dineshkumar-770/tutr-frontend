// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:tutr/resources/app_colors.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({
    super.key,
    this.size,
  });
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
      color: AppColors.loadingIndicatorColor,
      size: size ?? 40,
    ));
  }
}
