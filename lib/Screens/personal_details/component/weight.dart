import 'package:animated_weight_picker/animated_weight_picker.dart';
import 'package:swift_aid/components/custom_button.dart';
import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class WeightSelectionScreen extends StatefulWidget {
  const WeightSelectionScreen({super.key});

  @override
  WeightSelectionScreenState createState() => WeightSelectionScreenState();
}

class WeightSelectionScreenState extends State<WeightSelectionScreen> {
  final double min = 0;
  final double max = 200;
  String selectedValue = '0';

  @override
  void initState() {
    super.initState();
    selectedValue = min.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weight',
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
                'Select Your Weight',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 50),
            Text(
              'Selected Weight: $selectedValue kg',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: AnimatedWeightPicker(
                dialColor: AppColors.primaryColor,
                majorIntervalColor: Colors.red,
                showSelectedValue: true,
                showSuffix: true,
                suffixTextColor: AppColors.primaryColor,
                selectedValueColor: AppColors.primaryColor,
                selectedValueStyle:
                    const TextStyle(color: AppColors.primaryColor),
                min: min,
                max: max,
                onChange: (newValue) {
                  setState(() {
                    selectedValue = newValue;
                  });
                },
              ),
            ),
            const SizedBox(height: 50),
            CustomButton(
              backgroundColor: AppColors.primaryColor,
              borderRadius: 20,
              width: 200,
              text: "Confirm Weight",
              onPressed: () {
                Navigator.pop(context, selectedValue);
              },
            ),
          ],
        ),
      ),
    );
  }
}
