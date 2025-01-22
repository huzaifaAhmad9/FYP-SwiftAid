// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class Circle_Container extends StatelessWidget {
  final Widget icon;
  final double height;
  final double width;
  final Color color;
  final BoxShape shape; 
  final BoxFit fit; 

  const Circle_Container({
    super.key,
    required this.icon,
    required this.height,
    required this.width,
    required this.color,
    this.shape = BoxShape.circle, 
    this.fit = BoxFit.contain, 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        shape: shape, 
      ),
      child: Center(
        child: FittedBox(
          fit: fit, 
          child: icon,
        ),
      ),
    );
  }
}
