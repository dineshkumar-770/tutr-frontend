import 'package:flutter/material.dart';
import 'package:tutr_frontend/constants/app_colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      required this.label,
      required this.hint,
      this.validator,
      this.onChanged,
      required this.controller,
      this.suffix,
      this.autofocus,
      this.maxLines,
      this.textColor,
      this.fontWeight,
      this.enable,
      this.textInputType,
      this.maxLength,
      this.isPasswordField});
  final String label;
  final String hint;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final bool? isPasswordField;
  final void Function(String)? onChanged;
  final Widget? suffix;
  final bool? autofocus;
  final int? maxLines;
  final Color? textColor;
  final FontWeight? fontWeight;
  final bool? enable;
  final TextInputType? textInputType;
  final int? maxLength;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showPassword = true;
  @override
  Widget build(BuildContext context) {
    return widget.isPasswordField ?? false
        ? Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.label,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                    ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                child: TextFormField(
                  controller: widget.controller,
                  onChanged: widget.onChanged,
                  autofocus: widget.autofocus ?? false,
                  obscureText: showPassword,
                  enabled: widget.enable,
                  maxLines: widget.maxLines ?? 1,
                  keyboardType: widget.textInputType,
                  textInputAction: TextInputAction.done,
                  maxLength: widget.maxLength,
                  decoration: InputDecoration(
                    suffix: widget.suffix,
                    hintText: widget.hint,
                    hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontFamily: 'Poppins',
                          color: const Color(0xFFBAC2C7),
                          fontSize: 14,
                        ),
                    suffixIcon: widget.isPasswordField ?? false
                        ? InkWell(
                            onTap: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                            child: Icon(
                              showPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              color: const Color(0xFF757575),
                              size: 22,
                            ),
                          )
                        : Visibility(visible: widget.isPasswordField ?? false, child: const Icon(Icons.abc)),
                    filled: true,
                    fillColor: Color(0xFFE0E4E5),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontFamily: 'Poppins', color: widget.textColor, fontSize: 17, fontWeight: widget.fontWeight),
                  validator: widget.validator,
                ),
              ),
            ],
          )
        : Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.label,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                    ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                child: TextFormField(
                  onChanged: widget.onChanged,
                  controller: widget.controller,
                  autofocus: widget.autofocus ?? false,
                  maxLines: widget.maxLines ?? 1,
                  enabled: widget.enable,
                  keyboardType: widget.textInputType,
                  maxLength: widget.maxLength,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFE0E4E5),
                    hintText: widget.hint,
                    hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontFamily: 'Poppins',
                          color: AppColors.grey,
                          fontSize: 14,
                        ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontFamily: 'Poppins', fontSize: 17, color: widget.textColor, fontWeight: widget.fontWeight),
                  validator: widget.validator,
                ),
              ),
            ],
          );
  }
}
