import 'package:swift_aid/Screens/User_Screens/Home_Screen/components/top_builder_row.dart';
import 'package:swift_aid/Screens/User_Screens/Home_Screen/components/bottom_builder.dart';
import 'package:swift_aid/Screens/User_Screens/Home_Screen/components/title_builder.dart';
import 'package:swift_aid/Screens/User_Screens/Home_Screen/components/home_card.dart';
import 'package:swift_aid/Screens/personal_details/component/text_field.dart';
import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controllers = List.generate(1, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Column(
          children: [
            // Top content (non-scrollable)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  TitleBuilder(
                    textWidget: const Text(
                      'Find your desire\nhealth solution',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    imageWidget: Image.asset('assets/images/notification.png'),
                  ),
                ],
              ),
            ),
            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight * 0.03),
                      CustomTextFormField(
                        controller: _controllers[0],
                        cursor: AppColors.primaryColorLight,
                        errorBorderColor: AppColors.redColor,
                        borderColor: AppColors.primaryColor,
                        borderRadius: 20,
                        hintText: 'Search doctor, drugs, articles...',
                        keyboardType: TextInputType.name,
                        prefixIcon: const Icon(
                          CupertinoIcons.search,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      const TopBuilder(),
                      SizedBox(height: screenHeight * 0.03),
                      const HomeCardBuilder(),
                      SizedBox(height: screenHeight * 0.035),
                      const TitleBuilder(
                          textWidget: Text('Top Doctor',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          imageWidget: Text(
                            'See all',
                            style: TextStyle(color: AppColors.primaryColor),
                          )),
                      SizedBox(height: screenHeight * 0.035),
                      const BottomListView(),
                      SizedBox(height: screenHeight * 0.04),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controllers.asMap().forEach((i, c) => c.dispose());
    super.dispose();
  }
}
