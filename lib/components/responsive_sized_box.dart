import 'package:flutter/material.dart';

extension BoxSize on num {
  // For height Box
  Widget get heightBox {
    return ResponsiveSizedBox(height: toDouble());
  }

  // For width Box
  Widget get widthBox {
    return ResponsiveSizedBox(width: toDouble());
  }
}

class ResponsiveSizedBox extends StatelessWidget {
  final double? width;
  final double? height;

  const ResponsiveSizedBox({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Calculate responsive width/height based on percentage
    double finalWidth = width != null ? width! * screenWidth / 100 : 0;
    double finalHeight = height != null ? height! * screenHeight / 100 : 0;

    return SizedBox(
      width: finalWidth,
      height: finalHeight,
    );
  }
}
