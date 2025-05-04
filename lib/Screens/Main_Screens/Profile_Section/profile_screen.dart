// ignore_for_file: deprecated_member_use

import 'package:flutter/services.dart' show HapticFeedback;
import 'package:swift_aid/bloc/auth_bloc/auth_evetns.dart';
import 'package:swift_aid/components/custom_listtile.dart';
import 'package:swift_aid/Screens/auth/Login/login.dart';
import 'package:swift_aid/bloc/auth_bloc/auth_bloc.dart';
import 'package:swift_aid/components/custom_dialog.dart';
import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io' show File;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSwitched = false;
  File? profileImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(color: AppColors.primaryColorLight),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Image.asset('assets/images/design.png'),
                ),
                Column(
                  children: [
                    const SizedBox(height: 100),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: profileImage != null
                                  ? FileImage(profileImage!)
                                  : const AssetImage(
                                          'assets/images/profile.jpg')
                                      as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 3,
                          bottom: 1,
                          child: GestureDetector(
                            onTap: _showImagePickerSheet,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: const BoxDecoration(
                                color: AppColors.whiteColor,
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: AppColors.primaryColor,
                                  size: 13,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Center(
                      child: Text(
                        'Amelia Renata',
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Image.asset('assets/images/heart.png'),
                            const Text('Heart rate',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.textColor,
                                )),
                            const Text('215bpm',
                                style: TextStyle(
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                          ],
                        ),
                        Container(
                          color: AppColors.textColor,
                          height: 44,
                          width: 1,
                        ),
                        Column(
                          children: [
                            Image.asset('assets/images/fire.png'),
                            const Text('Calories',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.textColor,
                                )),
                            const Text('756cal',
                                style: TextStyle(
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                          ],
                        ),
                        Container(
                          color: AppColors.textColor,
                          height: 44,
                          width: 1,
                        ),
                        Column(
                          children: [
                            Image.asset('assets/images/weight.png'),
                            const Text('Weight',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.textColor,
                                )),
                            const Text('103lbs',
                                style: TextStyle(
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 360,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(left: 12),
                child: Column(
                  children: [
                    const SizedBox(height: 25),
                    CustomListTile(
                      leading: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          color: AppColors.textColor.withOpacity(.4),
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset('assets/images/doc.png'),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded),
                      title: 'Account Information',
                    ),
                    const Divider(
                      color: AppColors.lightGreyColor,
                      indent: 8.0,
                      endIndent: 16.0,
                    ),
                    CustomListTile(
                      leading: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          color: AppColors.textColor.withOpacity(.4),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.notifications_none_outlined,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      trailing: Transform.scale(
                        scale: 0.8,
                        child: Switch(
                          value: isSwitched,
                          activeTrackColor: AppColors.primaryColor,
                          thumbColor: MaterialStateProperty.all(Colors.white),
                          onChanged: (value) {
                            setState(() {
                              isSwitched = value;
                            });
                          },
                        ),
                      ),
                      title: 'Notifications',
                    ),
                    const Divider(
                      color: AppColors.lightGreyColor,
                      indent: 8.0,
                      endIndent: 16.0,
                    ),
                    CustomListTile(
                      leading: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          color: AppColors.textColor.withOpacity(.4),
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset('assets/images/chat.png'),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded),
                      title: 'FAQs',
                    ),
                    const Divider(
                      color: AppColors.lightGreyColor,
                      indent: 8.0,
                      endIndent: 16.0,
                    ),
                    CustomListTile(
                      onTap: () {
                        showCustomDialog(context);
                      },
                      leading: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          color: AppColors.textColor.withOpacity(.4),
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset('assets/images/danger.png'),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded),
                      title: 'Logout',
                      titleStyle: const TextStyle(
                        color: AppColors.redColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

//! Bottom Model Sheet
  void _showImagePickerSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            children: [
              ListTile(
                  leading: const Icon(
                    Icons.photo_library,
                    color: AppColors.primaryColor,
                  ),
                  title: const Text("Pick from Gallery"),
                  onTap: () {
                    HapticFeedback.lightImpact();
                    _pickImage(
                      ImageSource.gallery,
                    );
                  }),
              ListTile(
                leading: const Icon(
                  Icons.camera_alt,
                  color: AppColors.primaryColor,
                ),
                title: const Text("Take from Camera"),
                onTap: () {
                  HapticFeedback.lightImpact();
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

//! Pick image Function
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source, imageQuality: 85);

    if (pickedFile != null) {
      setState(() {
        profileImage = File(pickedFile.path);
      });
    }
    if (mounted) {
      Navigator.pop(context);
    }
  }
}

//! LogOut Dailogs
void showCustomDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return CustomDialog(
        confirmText: 'Logout',
        cancelText: 'Cancel',
        icon: const Icon(
          Icons.logout_outlined,
          size: 35.0,
          color: AppColors.primaryColor,
        ),
        title: 'Are you sure you want to log out?',
        onConfirm: () {
          context.read<AuthBloc>().add(LogoutEvent());
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const Login()),
            (route) => false,
          );
        },
      );
    },
  );
}
