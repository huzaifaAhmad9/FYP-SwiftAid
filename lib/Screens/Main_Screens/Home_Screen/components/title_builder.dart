import 'package:flutter/material.dart';

class TitleBuilder extends StatelessWidget {
  final Widget textWidget;
  final Widget imageWidget;

  const TitleBuilder({
    super.key,
    required this.textWidget,
    required this.imageWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          textWidget,
          imageWidget,
        ],
      ),
    );
  }
}
