import 'package:swift_aid/Screens/Splash_Screen/On_Boarding/on_boarding_main.dart';
import 'package:swift_aid/bloc/hospital_auth_bloc/hospital_auth_bloc.dart';
import 'package:swift_aid/Screens/hospital/hospital_dashboard.dart';
import 'package:swift_aid/Screens/User_Screens/main_home.dart';
import 'package:swift_aid/bloc/auth_bloc/auth_bloc.dart';
import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class MainSplash extends StatefulWidget {
  const MainSplash({super.key});

  @override
  State<MainSplash> createState() => _MainSplashState();
}

class _MainSplashState extends State<MainSplash> {
  String? isLoggedIn;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final authBloc = AuthBloc();
    final hospitalBloc = HospitalAuthBloc();

    final userLogin = await authBloc.isUserLoggedIn();
    final hospitalLogin = await hospitalBloc.isUserLoggedIn();

    if (userLogin != null) {
      isLoggedIn = userLogin;
    } else if (hospitalLogin != null) {
      isLoggedIn = hospitalLogin;
    } else {
      isLoggedIn = null;
    }

    Future.delayed(const Duration(seconds: 3), () {
      if (isLoggedIn == 'user') {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainHome()),
          );
        }
      } else if (isLoggedIn == 'hospital') {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HospitalDashboard()),
          );
        }
      } else {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const OnBoardingMain()),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/splash.png'),
            const SizedBox(
              height: 20,
            ),
            const Text('Swift Aid',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: AppColors.whiteColor,
                ))
          ],
        ),
      ),
    );
  }
}
