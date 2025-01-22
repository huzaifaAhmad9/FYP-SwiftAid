import 'package:swift_aid/components/circle_container.dart';
import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class TopBuilder extends StatefulWidget {
  const TopBuilder({super.key});

  @override
  State<TopBuilder> createState() => _TopBuilderState();
}

class _TopBuilderState extends State<TopBuilder> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Circle_Container(
              icon: Image.asset('assets/images/docr.png'),
              height: 50,
              width: 50,
              color: Colors.transparent,
            ),
            const Text(
              'Doctor',
              style: TextStyle(color: AppColors.greyColor),
            )
          ],
        ),
        Column(
          children: [
            Circle_Container(
              icon: Image.asset('assets/images/pharmacy.png'),
              height: 50,
              width: 50,
              color: Colors.transparent,
            ),
            const Text(
              'Pharmacy',
              style: TextStyle(color: AppColors.greyColor),
            )
          ],
        ),
        Column(
          children: [
            Circle_Container(
              icon: Image.asset('assets/images/hospital.png'),
              height: 50,
              width: 50,
              color: Colors.transparent,
            ),
            const Text(
              'Hospital',
              style: TextStyle(color: AppColors.greyColor),
            )
          ],
        ),
        Column(
          children: [
            Circle_Container(
              icon: Image.asset('assets/images/ambulance.png'),
              height: 50,
              width: 50,
              color: Colors.transparent,
            ),
            const Text(
              'Ambulance',
              style: TextStyle(color: AppColors.greyColor),
            )
          ],
        ),
      ],
    );
  }
}
