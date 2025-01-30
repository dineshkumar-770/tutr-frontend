import 'package:flutter/material.dart';

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
                      fontFamily: 'InterTight',
                      fontSize: 12,
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
                  decoration: InputDecoration(
                    suffix: widget.suffix,
                    hintText: widget.hint,
                    hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontFamily: 'InterTight',
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
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFFBAC2C7),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFFBAC2C7),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFFBAC2C7),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontFamily: 'InterTight', color: widget.textColor, fontSize: 17, fontWeight: widget.fontWeight),
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
                      fontFamily: 'InterTight',
                      fontSize: 12,
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
                   textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    suffix: widget.suffix,
                    hintText: widget.hint,
                    hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontFamily: 'InterTight',
                          color: const Color(0xFFBAC2C7),
                          fontSize: 14,
                        ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFFBAC2C7),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFFBAC2C7),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFFBAC2C7),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontFamily: 'InterTight', fontSize: 17, color: widget.textColor, fontWeight: widget.fontWeight),
                  validator: widget.validator,
                ),
              ),
            ],
          );
  }
}
