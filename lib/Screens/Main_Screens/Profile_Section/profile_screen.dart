// ignore_for_file: deprecated_member_use

import 'package:swift_aid/Screens/auth/SignUp/prefereces/user_preferences.dart';
import 'package:swift_aid/bloc/hospital_auth_bloc/hospital_auth_event.dart';
import 'package:swift_aid/bloc/hospital_auth_bloc/hospital_auth_bloc.dart';
import 'package:swift_aid/bloc/user_bloc/file_upload_cubit.dart';
import 'package:flutter/services.dart' show HapticFeedback;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swift_aid/bloc/auth_bloc/auth_evetns.dart';
import 'package:swift_aid/components/custom_listtile.dart';
import 'package:swift_aid/bloc/user_bloc/user_event.dart';
import 'package:swift_aid/bloc/user_bloc/user_state.dart';
import 'package:swift_aid/Screens/auth/Login/login.dart';
import 'package:swift_aid/bloc/auth_bloc/auth_bloc.dart';
import 'package:swift_aid/bloc/user_bloc/user_bloc.dart';
import 'package:swift_aid/components/custom_dialog.dart';
import 'package:swift_aid/Models/hospital_model.dart';
import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:swift_aid/Models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:developer' show log;
import 'dart:io' show File;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSwitched = false;
  File? profileImage;
  UserModel? user;
  HospitalModel? hospital;
  bool isLoading = true;
  String? token;
  String? isLoggedIn;
  @override
  void initState() {
    super.initState();
    _loadProfileImage();
    retrieveUserData();
  }

  Future<void> retrieveUserData() async {
    await _checkLoggedInUser();
    log('isLoggedIn: $isLoggedIn');

    if (mounted) {
      if (isLoggedIn == 'user') {
        context.read<UserBloc>().add(FetchUserEvent());
      }
      //else if (isLoggedIn == 'hospital') {}
    }
  }

  Future<void> _checkLoggedInUser() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('auth_token')) {
      token = prefs.getString('auth_token');

      isLoggedIn = 'user';
      log('User token: $token');
    }

    // token = prefs.getString('hospital_auth_token');
    // if (token != null) {
    //   isLoggedIn = 'hospital';
    //   log('Hospital token: $token');
    // }

    // If no token found, log a message or set a default state
    if (isLoggedIn == null) {
      log('No token found, user not logged in');
    }
  }

  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('profileImagePath_$token');
    if (imagePath != null) {
      setState(() {
        profileImage = File(imagePath);
      });
    }
  }

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
                        BlocBuilder<UserBloc, UserState>(
                          builder: (BuildContext context, UserState state) {
                            return Container(
                              width: 130,
                              height: 130,
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
                            );
                          },
                        ),
                        Positioned(
                          right: 7,
                          bottom: 7,
                          child: GestureDetector(
                            onTap: _showImagePickerSheet,
                            child: Container(
                              width: 25,
                              height: 25,
                              decoration: const BoxDecoration(
                                color: AppColors.whiteColor,
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: AppColors.primaryColor,
                                  size: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        if (state is UserLoadedState) {
                          return Center(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    state.userModel.name!,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    state.userModel.email!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ]),
                          );
                        } else if (state is UserLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.whiteColor,
                              strokeWidth: 2,
                            ),
                          );
                        } else if (state is UserErrorState) {
                          return Center(
                            child: Text(
                              state.message,
                              style: const TextStyle(
                                fontSize: 18,
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     Column(
                    //       children: [
                    //         Image.asset('assets/images/heart.png'),
                    //         const Text('Heart rate',
                    //             style: TextStyle(
                    //               fontSize: 10,
                    //               color: AppColors.textColor,
                    //             )),
                    //         const Text('215bpm',
                    //             style: TextStyle(
                    //                 color: AppColors.whiteColor,
                    //                 fontWeight: FontWeight.bold,
                    //                 fontSize: 16)),
                    //       ],
                    //     ),
                    //     Container(
                    //       color: AppColors.textColor,
                    //       height: 44,
                    //       width: 1,
                    //     ),
                    //     Column(
                    //       children: [
                    //         Image.asset('assets/images/fire.png'),
                    //         const Text('Calories',
                    //             style: TextStyle(
                    //               fontSize: 10,
                    //               color: AppColors.textColor,
                    //             )),
                    //         const Text('756cal',
                    //             style: TextStyle(
                    //                 color: AppColors.whiteColor,
                    //                 fontWeight: FontWeight.bold,
                    //                 fontSize: 16)),
                    //       ],
                    //     ),
                    //     Container(
                    //       color: AppColors.textColor,
                    //       height: 44,
                    //       width: 1,
                    //     ),
                    //     Column(
                    //       children: [
                    //         Image.asset('assets/images/weight.png'),
                    //         const Text('Weight',
                    //             style: TextStyle(
                    //               fontSize: 10,
                    //               color: AppColors.textColor,
                    //             )),
                    //         const Text('103lbs',
                    //             style: TextStyle(
                    //                 color: AppColors.whiteColor,
                    //                 fontWeight: FontWeight.bold,
                    //                 fontSize: 16)),
                    //       ],
                    //     ),
                    //   ],
                    // )
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
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const UserPreferences()));
                      },
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
                        log("isloggedIn: $isLoggedIn");
                        showCustomDialog(context, isLoggedIn!);
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
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profileImagePath_$token', pickedFile.path);
      setState(() {
        profileImage = File(pickedFile.path);
      });
      if (mounted) {
        log('Picked file path: ${pickedFile.path}');

        log(" before file uploaded trigger");
        if (isLoggedIn == 'user') {
          context.read<FileUploadCubit>().uploadFile(pickedFile.path);
          log(" afer file uploaded trigger");
        } else {
          return;
        }
      }
    }
    if (mounted) {
      Navigator.pop(context);
    }
  }
}

//! LogOut Dailogs
void showCustomDialog(BuildContext context, String user) {
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
          user == 'user'
              ? context.read<AuthBloc>().add(LogoutEvent())
              : context.read<HospitalAuthBloc>().add(LogoutHospital());
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
