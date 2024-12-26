import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final double height;
  final double width;
  final double borderRadius;
  final double fontSize;
  final double borderWidth;

  const CustomButton(
      {required this.text,
      required this.onPressed,
      this.textColor,
      this.backgroundColor,
      this.borderColor,
      this.height = 50.0,
      this.width = double.infinity,
      this.borderRadius = 8.0,
      this.fontSize = 16.0,
      this.borderWidth = 2.0,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: textColor ?? Colors.white,
          backgroundColor: backgroundColor ?? Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(
              color: borderColor ?? Colors.transparent,
              width: borderWidth,
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
