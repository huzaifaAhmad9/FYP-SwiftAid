import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final TextStyle? labelStyle;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final Color borderColor;
  final Color? cursor;
  final double borderRadius;
  final Color errorBorderColor;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  const CustomTextFormField({
    super.key,
    this.hintText,
    this.labelText,
    this.labelStyle,
    this.controller,
    this.validator,
    this.cursor,
    this.keyboardType = TextInputType.text,
    this.borderColor = Colors.blue,
    this.errorBorderColor = Colors.red,
    this.borderRadius = 10.0,
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      cursorColor: cursor,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        labelStyle: labelStyle ?? TextStyle(color: borderColor),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: borderColor,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: borderColor,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: borderColor,
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: errorBorderColor,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: errorBorderColor,
            width: 1,
          ),
        ),
      ),
    );
  }
}
