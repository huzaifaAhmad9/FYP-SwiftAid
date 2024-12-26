// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class Circle_Container extends StatelessWidget {
  final Widget icon;
  final double height;
  final double width;
  final Color color;

  const Circle_Container({
    super.key,
    required this.icon,
    required this.height,
    required this.width,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: icon,
      ),
    );
  }
}
