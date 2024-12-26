import 'package:swift_aid/components/custom_text_button.dart';
import 'package:swift_aid/components/circle_container.dart';
import 'package:swift_aid/components/custom_button.dart';
import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final double? height;
  final double? width;
  final String? title;
  final String? description;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final Widget? icon;

  const CustomDialog({
    super.key,
    this.height,
    this.width,
    this.title,
    this.description,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    required this.onConfirm,
    this.onCancel,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(23.0),
      ),
      child: Container(
        height: height ?? MediaQuery.of(context).size.height * 0.45,
        width: width ?? MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Circle_Container(
              icon: icon ??
                  const Icon(
                    Icons.info,
                    size: 35.0,
                    color: AppColors.primaryColor,
                  ),
              height: 90,
              width: 90,
              color: AppColors.lightWhite,
            ),
            const SizedBox(
              height: 20,
            ),
            if (title != null)
              Text(
                title!,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            if (title != null) const SizedBox(height: 8.0),
            if (description != null)
              Text(
                description!,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            if (description != null) const SizedBox(height: 16.0),
            const SizedBox(
              height: 25,
            ),
            CustomButton(
              backgroundColor: AppColors.primaryColor,
              height: 54,
              width: 183,
              borderRadius: 30.0,
              text: confirmText,
              textColor: Colors.white,
              onPressed: onConfirm,
            ),
            const SizedBox(height: 10),
            CustomTextButton(
              text: cancelText,
              textStyle: const TextStyle(
                fontSize: 16.0,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
              alignment: Alignment.center,
              onPressed: onCancel ?? () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
