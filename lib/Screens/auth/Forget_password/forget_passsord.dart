import 'package:swift_aid/Screens/auth/components/custom_field.dart';
import 'package:swift_aid/components/responsive_sized_box.dart';
import 'package:swift_aid/bloc/auth_bloc/auth_evetns.dart';
import 'package:swift_aid/bloc/auth_bloc/auth_state.dart';
import 'package:swift_aid/bloc/auth_bloc/auth_bloc.dart';
import 'package:swift_aid/Screens/auth/Login/login.dart';
import 'package:swift_aid/components/custom_button.dart';
import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_aid/utils/utils.dart';
import 'package:flutter/material.dart';
import 'dart:developer' show log;

class ForgetPasssord extends StatefulWidget {
  const ForgetPasssord({super.key});

  @override
  State<ForgetPasssord> createState() => _ForgetPasssordState();
}

class _ForgetPasssordState extends State<ForgetPasssord> {
  late final TextEditingController _email = TextEditingController();
  late FocusNode _emailFocus;
  final _formKey = GlobalKey<FormState>();
  bool _isEmailValid = false;

  void _checkEmail() {
    setState(() {
      _isEmailValid = Utils.isValidEmail(_email.text);
    });
  }

  @override
  void initState() {
    _emailFocus = FocusNode();

    _emailFocus.addListener(() {
      setState(() {});
    });
    _email.addListener(_checkEmail);
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _emailFocus.dispose();
    super.dispose();
  }

  void customDialogue() {
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

              // Show success dialog first
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

  void sendResetPasssword(String email) {
    context.read<AuthBloc>().add(ForgetPasswordEvent(email: email));
    customDialogue();
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
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              2.heightBox,
              const Text(
                'Enter your email address to reset your password and link will be sent on your gmail wherer you create new password:',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              3.heightBox,
              CustomField(
                controller: _email,
                hintText: 'Enter your email',
                focusNode: _emailFocus,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  } else if (!_isEmailValid) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/Email.png',
                    height: 20,
                    width: 20,
                    color: _emailFocus.hasFocus
                        ? AppColors.primaryColor
                        : AppColors.greyColor,
                  ),
                ),
                suffixIcon: _isEmailValid
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                      )
                    : null,
                obscureText: false,
              ),
              5.heightBox,
              CustomButton(
                text: "Reset ",
                onPressed: () {
                  final email = _email.text.trim();
                  if (_formKey.currentState!.validate()) {
                    sendResetPasssword(email);
                  }
                },
                height: 50,
                width: 200,
                backgroundColor: AppColors.primaryColor,
                borderRadius: 30,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDialog(BuildContext context,
      {required Widget content, required String title}) {
    return AlertDialog(
      title: Text(title),
      content: content,
    );
  }
}
