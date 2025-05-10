import 'package:swift_aid/components/custom_button.dart';
import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class HomeCardBuilder extends StatefulWidget {
  const HomeCardBuilder({super.key});

  @override
  State<HomeCardBuilder> createState() => _HomeCardBuilderState();
}

class _HomeCardBuilderState extends State<HomeCardBuilder> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: 195,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.primaryColorLight.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(25)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25, left: 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Early protection for\nyour family health',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: screenHeight * 0.02),
                CustomButton(
                  borderRadius: 30,
                  backgroundColor: AppColors.primaryColor,
                  width: 150,
                  text: 'Learn more',
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                'assets/images/dr2.png',
                scale: 2.5,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
