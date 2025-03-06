import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class EmergencyRegistration extends StatefulWidget {
  const EmergencyRegistration({super.key});

  @override
  State<EmergencyRegistration> createState() => _EmergencyRegistrationState();
}

class _EmergencyRegistrationState extends State<EmergencyRegistration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registration',
          style: TextStyle(color: AppColors.whiteColor),
        ),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}
