import 'package:flutter/material.dart';

class RoundSelectionIndicator extends StatelessWidget {
  final bool isSelected;
  final Color selectedColor;
  final Color unselectedColor;

  const RoundSelectionIndicator({
    super.key,
    required this.isSelected,
    this.selectedColor = Colors.red,
    this.unselectedColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color:
                isSelected ? selectedColor : unselectedColor.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Center(
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? selectedColor : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
