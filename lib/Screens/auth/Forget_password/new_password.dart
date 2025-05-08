// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_aid/Screens/auth/Login/login.dart';
import 'package:swift_aid/Screens/personal_details/component/text_field.dart';
import 'package:swift_aid/bloc/auth_bloc/auth_bloc.dart';
import 'package:swift_aid/bloc/auth_bloc/auth_evetns.dart';
import 'package:swift_aid/bloc/auth_bloc/auth_state.dart';
import 'package:swift_aid/bloc/hospital_auth_bloc/hospital_auth_bloc.dart';
import 'package:swift_aid/bloc/hospital_auth_bloc/hospital_auth_event.dart';
import 'package:swift_aid/bloc/hospital_auth_bloc/hospital_auth_state.dart';
import 'package:swift_aid/components/responsive_sized_box.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swift_aid/components/custom_button.dart';
import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class PasswordResetScreen extends StatefulWidget {
  final String userType;
  const PasswordResetScreen({super.key, required this.userType});

  @override
  _PasswordResetScreenState createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _otpController = TextEditingController();
  bool _isPassHidden = true;
  bool _isConfirmPasswordHidden = true;
  bool _showVerifiedIcon = false;

  void customDialogueForUser() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthloadingState) {
              return _buildDialog(
                context,
                content: const Row(
                  children: [
                    Spacer(),
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                title: "Loading...",
              );
            }

            if (state is AuthSucessState) {
              log("Success state triggered");

              _buildDialog(
                context,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      state.message,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    2.heightBox,
                    const Icon(
                      Icons.check_circle,
                      color: AppColors.primaryColor,
                      size: 50.0,
                    ),
                  ],
                ),
                title: "Success",
              );

              // Trigger navigation after the dialog is shown
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const Login()));
              });
            }

            if (state is AuthErrorState) {
              return _buildDialog(
                context,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      state.message,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    2.heightBox,
                    const Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 50.0,
                    ),
                  ],
                ),
                title: "Error",
              );
            }

            return const SizedBox();
          },
        );
      },
    );
  }

  void customDialogueForHospital() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<HospitalAuthBloc, HospitalAuthState>(
          builder: (context, state) {
            if (state is HospitalLoading) {
              return _buildDialog(
                context,
                content: const Row(
                  children: [
                    Spacer(),
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                title: "Loading...",
              );
            }

            if (state is HospitalSuccess) {
              log("Success state triggered");

              _buildDialog(
                context,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      state.message,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    2.heightBox,
                    const Icon(
                      Icons.check_circle,
                      color: AppColors.primaryColor,
                      size: 50.0,
                    ),
                  ],
                ),
                title: "Success",
              );

              // Trigger navigation after the dialog is shown
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const Login()));
              });
            }

            if (state is HospitalFailure) {
              return _buildDialog(
                context,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      state.error,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    2.heightBox,
                    const Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 50.0,
                    ),
                  ],
                ),
                title: "Error",
              );
            }

            return const SizedBox();
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _otpController.addListener(_checkOtpLength);
  }

  void reset(String otp, String password) {
    if (widget.userType == 'user') {
      context.read<AuthBloc>().add(ResetPasswordEvent(otp, password));
      customDialogueForUser();
    } else if (widget.userType == 'hospital') {
      context
          .read<HospitalAuthBloc>()
          .add(ResetHospitalPassword(otp, password));
      customDialogueForHospital();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text('Forget Password',
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              8.heightBox,
              const Center(
                child: Icon(
                  FontAwesomeIcons.lock,
                  color: AppColors.primaryColor,
                  size: 60,
                ),
              ),
              5.heightBox,
              const Text(
                'Please Confirm your new Password',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              3.heightBox,
              CustomTextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                ],
                controller: _otpController,
                borderColor: AppColors.primaryColor,
                hintText: 'Enter Otp',
                labelText: 'OTP',
                cursor: AppColors.primaryColor,
                keyboardType: TextInputType.number,
                suffixIcon: _showVerifiedIcon
                    ? const Icon(Icons.verified, color: Colors.green)
                    : null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the OTP which you receive on your mail';
                  }
                  if (value.length != 4) {
                    return 'OTP must be 4 digits';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                maxLines: 1,
                obscureText: _isPassHidden,
                prefixIcon:
                    const Icon(Icons.password, color: AppColors.primaryColor),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPassHidden ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.primaryColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPassHidden = !_isPassHidden;
                    });
                  },
                ),
                controller: _newPasswordController,
                borderColor: AppColors.primaryColor,
                hintText: 'Enter New Password',
                labelText: 'New Password',
                cursor: AppColors.primaryColor,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a new password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                maxLines: 1,
                obscureText: _isConfirmPasswordHidden,
                controller: _confirmPasswordController,
                borderColor: AppColors.primaryColor,
                hintText: 'Confirm New Password',
                labelText: 'Confirm Password',
                prefixIcon:
                    const Icon(Icons.password, color: AppColors.primaryColor),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isConfirmPasswordHidden
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: AppColors.primaryColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _isConfirmPasswordHidden = !_isConfirmPasswordHidden;
                    });
                  },
                ),
                cursor: AppColors.primaryColor,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != _newPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Center(
                child: CustomButton(
                  text: 'Reset',
                  onPressed: _submitForm,
                  backgroundColor: AppColors.primaryColor,
                  borderRadius: 24,
                  width: 240,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _checkOtpLength() {
    setState(() {
      _showVerifiedIcon = _otpController.text.length == 4;
    });
  }

  @override
  void dispose() {
    _otpController.removeListener(_checkOtpLength);
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String newPassword = _confirmPasswordController.text.trim();
      String otp = _otpController.text.trim();

      reset(otp, newPassword);
    }
  }

  Widget _buildDialog(BuildContext context,
      {required Widget content, required String title}) {
    return AlertDialog(
      title: Text(title),
      content: content,
    );
  }
}
