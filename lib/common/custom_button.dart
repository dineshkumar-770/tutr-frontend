import 'package:flutter/material.dart';
import 'package:tutr/resources/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.color,
      required this.onTap,
      required this.label,
      this.iconData,
      this.width,
      this.height,
      this.labelColor,
      this.iconSize});
  final Color? color;
  final void Function()? onTap;
  final Widget label;
  final IconData? iconData;
  final double? width;
  final double? height;
  final double? iconSize;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? 40,
      child: ElevatedButton.icon(
        label: label,
        icon: Icon(
          iconData,
          size: iconSize ?? 0,
          color: AppColors.textColor1,
        ),
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(color ?? AppColors.primaryButtonColor),
          shape: const WidgetStatePropertyAll(StadiumBorder()),
        ),
        onPressed: onTap,
      ),
    );
  }
}
