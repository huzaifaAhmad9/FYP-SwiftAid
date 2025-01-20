import 'package:scroll_wheel_date_picker/scroll_wheel_date_picker.dart';
import 'package:swift_aid/components/custom_button.dart';
import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class DOBPickerScreen extends StatefulWidget {
  const DOBPickerScreen({super.key});

  @override
  State<DOBPickerScreen> createState() => _DOBPickerScreenState();
}

class _DOBPickerScreenState extends State<DOBPickerScreen> {
  DateTime selectedDate = DateTime(2000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Date of Birth',
          style: TextStyle(color: AppColors.whiteColor),
        ),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: AppColors.whiteColor,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                'Select Your Date of Birth',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 250,
                child: ScrollWheelDatePicker(
                  initialDate: selectedDate,
                  lastDate: DateTime(2025, 12, 31),
                  loopDays: true,
                  loopMonths: true,
                  loopYears: true,
                  onSelectedItemChanged: (DateTime newDate) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (newDate.month != selectedDate.month ||
                          newDate.year != selectedDate.year) {
                        selectedDate = newDate;
                      }
                    });
                  },
                  theme: CurveDatePickerTheme(
                    itemExtent: 40,
                    wheelPickerHeight: 320,
                    itemTextStyle: const TextStyle(
                      fontSize: 18,
                      color: AppColors.primaryColorLight,
                    ),
                    overlayColor: AppColors.primaryColor.withValues(alpha: 0.4),
                    fadeEdges: true,
                    overlay: ScrollWheelDatePickerOverlay.line,
                    diameterRatio: 1.1,
                    overAndUnderCenterOpacity: 0.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              backgroundColor: AppColors.primaryColor,
              borderRadius: 20,
              text: 'Select Date',
              width: 200,
              onPressed: () {
                Navigator.pop(context, selectedDate);
              },
            )
          ],
        ),
      ),
    );
  }
}
