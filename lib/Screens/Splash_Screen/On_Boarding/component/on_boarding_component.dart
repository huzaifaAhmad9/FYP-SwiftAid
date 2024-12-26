// ignore_for_file: deprecated_member_use

import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class MultiStepWidget extends StatefulWidget {
  final List<Map<String, dynamic>> steps;
  final VoidCallback? onFinish;

  const MultiStepWidget({
    required this.steps,
    this.onFinish,
    super.key,
  });

  @override
  State<MultiStepWidget> createState() => _MultiStepWidgetState();
}

class _MultiStepWidgetState extends State<MultiStepWidget> {
  int currentStep = 0;

  void nextStep() {
    if (currentStep < widget.steps.length - 1) {
      setState(() {
        currentStep++;
      });
    } else {
      widget.onFinish?.call();
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final stepData = widget.steps[currentStep];

    return WillPopScope(
      onWillPop: () async {
        if (currentStep == 0) {
          SystemNavigator.pop();
          return false;
        } else {
          previousStep();
          return false;
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 100,
          ),
          SizedBox(
            height: 400,
            child: widget.steps[currentStep]['centerWidget'],
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Text(
              stepData['title'],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 70,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 20),
            child: Row(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(widget.steps.length, (index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      height: 8.0,
                      width: 20.0,
                      decoration: BoxDecoration(
                        color: index == currentStep
                            ? AppColors.primaryColor
                            : Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    );
                  }),
                ),
                const Spacer(),
                Container(
                  height: 70,
                  width: 70,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                      onPressed: nextStep,
                      icon: const Icon(
                        Icons.arrow_right_alt,
                        color: AppColors.whiteColor,
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
