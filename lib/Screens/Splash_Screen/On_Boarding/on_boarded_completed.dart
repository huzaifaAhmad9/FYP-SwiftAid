//import 'package:swift_aid/Screens/auth/SignUp/sign.dart';
import 'package:swift_aid/Screens/auth/SignUp/verify_otp.dart';
import 'package:swift_aid/components/custom_button.dart';
import 'package:swift_aid/Screens/auth/Login/login.dart';
import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class OnBoardedCompleted extends StatefulWidget {
  const OnBoardedCompleted({super.key});

  @override
  State<OnBoardedCompleted> createState() => _OnBoardedCompletedState();
}

class _OnBoardedCompletedState extends State<OnBoardedCompleted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/onboard_complete.png'),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Swift Aid',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Let’s get started!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Login to enjoy the features we’ve\n provided, and stay healthy!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
            ),
            const SizedBox(
              height: 50,
            ),
            CustomButton(
                backgroundColor: AppColors.primaryColor,
                height: 56,
                width: 263,
                borderRadius: 60.0,
                textColor: AppColors.whiteColor,
                text: 'Login',
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const Login()));
                }),
            const SizedBox(
              height: 17,
            ),
            CustomButton(
                backgroundColor: AppColors.whiteColor,
                height: 56,
                width: 263,
                borderRadius: 60.0,
                textColor: AppColors.primaryColor,
                text: 'Sign Up',
                borderColor: AppColors.primaryColor,
                borderWidth: 1.0,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const VerifyOtp(),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
