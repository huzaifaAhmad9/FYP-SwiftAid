import 'package:flutter/material.dart';
import 'dart:math' show max, min;

class CustomText extends StatelessWidget {
  final TextOverflow? overflow;
  final Color? backgroundColor;
  final bool shadowEnable;
  final FontWeight weight;
  final TextAlign? align;
  final bool lineThrough;
  final double? height;
  final bool underline;
  final bool isCenter;
  final String? family;
  final int? maxLines;
  final String text;
  final double? size;
  final Color color;
  const CustomText({
    super.key,
    required this.text,
    this.shadowEnable = false,
    this.lineThrough = false,
    this.underline = false,
    this.isCenter = false,
    this.height,
    this.align,
    this.maxLines,
    this.color = Colors.black,
    this.size,
    this.overflow,
    this.backgroundColor,
    this.weight = FontWeight.normal,
    this.family,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: myStyle(
        color: color,
        size: size ?? 14.0,
        weight: weight,
        family: family ?? '',
        height: height,
        underline: underline,
        lineThrough: lineThrough,
        shadowEnable: shadowEnable,
        backgroundColor: backgroundColor,
      ),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: isCenter ? TextAlign.center : align,
      textScaler: TextScaler.linear(
        textScaleFactor(context),
      ),
    );
  }
}

TextStyle myStyle({
  Color color = Colors.black,
  double size = 14,
  bool shadowEnable = false,
  bool lineThrough = false,
  bool underline = false,
  FontWeight weight = FontWeight.normal,
  String family = '',
  double? height,
  Color? backgroundColor,
}) {
  return TextStyle(
    color: color,
    fontFamily: family,
    fontSize: size,
    shadows: shadowEnable
        ? [
            Shadow(
              offset: const Offset(1, 1),
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 1.0,
            ),
          ]
        : null,
    backgroundColor: backgroundColor,
    decoration: underline
        ? TextDecoration.underline
        : lineThrough
            ? TextDecoration.lineThrough
            : null,
    decorationThickness: 4,
    decorationColor: color,
    fontWeight: weight,
    height: height,
  );
}

double textScaleFactor(
  BuildContext context, {
  double maxTextScaleFactor = 2,
}) {
  final width = MediaQuery.of(context).size.width;
  double val = (width / 1400) * maxTextScaleFactor;
  return max(1, min(val, maxTextScaleFactor));
}
