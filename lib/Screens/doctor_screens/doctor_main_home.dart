import 'package:swift_aid/Screens/Main_Screens/Profile_Section/profile_screen.dart';
import 'package:swift_aid/Screens/Main_Screens/Location/location_screen.dart';
import 'package:swift_aid/Screens/doctor_screens/doctor_home_screen.dart';
import 'package:swift_aid/Screens/Main_Screens/message_screen.dart';
import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoctorMainHome extends StatefulWidget {
  const DoctorMainHome({super.key});

  @override
  State<DoctorMainHome> createState() => _DoctorMainHomeState();
}

class _DoctorMainHomeState extends State<DoctorMainHome> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DoctorHomeScreen(),
    const MessageScreen(),
    const LocationScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.whiteColor,
        elevation: 2.0,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 25,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_2_outlined,
              size: 25,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.chat_bubble,
              size: 25,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              size: 25,
            ),
            label: '',
          ),
        ],
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.greyColor,
      ),
    );
  }
}
