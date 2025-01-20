import 'package:cupertino_height_picker/cupertino_height_picker.dart';
import 'package:swift_aid/components/custom_button.dart';
import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class HeightSelectionScreen extends StatefulWidget {
  const HeightSelectionScreen({super.key});

  @override
  HeightSelectionScreenState createState() => HeightSelectionScreenState();
}

class HeightSelectionScreenState extends State<HeightSelectionScreen> {
  double heightInCm = 0.0;
  HeightUnit selectedHeightUnit = HeightUnit.cm;
  bool canConvertUnit = true;
  bool showSeparationText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Height',
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
                'Select Your Height',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Height: ${heightInCm.toStringAsFixed(1)} cm",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 50),
                    CustomButton(
                      backgroundColor: AppColors.primaryColor,
                      borderRadius: 20,
                      width: 200,
                      text: "Pick height",
                      onPressed: () async {
                        await showCupertinoHeightPicker(
                          context: context,
                          initialHeight: heightInCm,
                          initialSelectedHeightUnit: selectedHeightUnit,
                          canConvertUnit: canConvertUnit,
                          showSeparationText: showSeparationText,
                          onHeightChanged: (val) {
                            setState(() {
                              heightInCm = val;
                            });
                          },
                        );
                        if (context.mounted) {
                          Navigator.pop(context, heightInCm.toStringAsFixed(1));
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
