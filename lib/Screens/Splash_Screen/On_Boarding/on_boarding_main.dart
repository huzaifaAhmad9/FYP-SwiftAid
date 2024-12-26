import 'package:swift_aid/Screens/Splash_Screen/On_Boarding/component/on_boarding_component.dart';
import 'package:swift_aid/Screens/Splash_Screen/On_Boarding/on_boarded_completed.dart';
import 'package:flutter/material.dart';
import 'package:swift_aid/app_colors/app_colors.dart';

class OnBoardingMain extends StatefulWidget {
  const OnBoardingMain({super.key});

  @override
  State<OnBoardingMain> createState() => _OnBoardingMainState();
}

class _OnBoardingMainState extends State<OnBoardingMain> {
  @override
  Widget build(BuildContext context) {
    final steps = [
      {
        'centerWidget': Image.asset('assets/images/dr2.png'),
        'title': 'Consult only with a doctor you trust',
      },
      {
        'centerWidget': Image.asset('assets/images/dr3.png'),
        'title': 'Find a lot of specialist doctors in one place',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: MultiStepWidget(
        steps: steps,
        onFinish: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const OnBoardedCompleted(),
            ),
          );
        },
      ),
    );
  }
}
