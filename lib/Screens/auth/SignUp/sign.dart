// ignore_for_file: deprecated_member_use

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_aid/Screens/auth/bloc/auth_bloc.dart';
import 'package:swift_aid/Screens/auth/bloc/auth_evetns.dart';
import 'package:swift_aid/Screens/auth/components/custom_dialogue.dart';
import 'package:swift_aid/Screens/auth/components/custom_field.dart';
import 'package:swift_aid/components/custom_button.dart';
import 'package:swift_aid/Screens/auth/Login/login.dart';
import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:swift_aid/utils/utils.dart';
import 'package:flutter/material.dart';

class Sign extends StatefulWidget {
  const Sign({super.key});

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  late TextEditingController _name;
  late TextEditingController _email;
  late TextEditingController _password;
  late FocusNode _nameFocus;
  late FocusNode _emailFocus;
  late FocusNode _passwordFocus;
  bool _obscurePassword = true;
  bool _isEmailValid = false;
  bool _isChecked = false;

  void signUp() async {
    final email = _email.text.trim();
    final password = _password.text.trim();
    final name = _name.text.trim();

    context
        .read<AuthBloc>()
        .add(SignupEvent(email: email, password: password, name));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CustomDialogue();
      },
    );
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();

    _nameFocus = FocusNode();
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
    _email.addListener(_checkEmail);

    _nameFocus.addListener(() {
      setState(() {});
    });
    _emailFocus.addListener(() {
      setState(() {});
    });
    _passwordFocus.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  void _checkEmail() {
    setState(() {
      _isEmailValid = Utils.isValidEmail(_email.text);
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'SignUp',
            style: TextStyle(color: AppColors.secondaryColor),
          ),
          centerTitle: true,
          backgroundColor: AppColors.primaryColor,
          iconTheme: const IconThemeData(color: AppColors.secondaryColor),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 30),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      CustomField(
                        controller: _name,
                        hintText: "Enter your name",
                        obscureText: false,
                        focusNode: _nameFocus,
                        prefixIcon: Image.asset(
                          'assets/images/user.png',
                          height: 20,
                          width: 20,
                          color: _nameFocus.hasFocus
                              ? const Color.fromARGB(255, 18, 109, 100)
                              : Colors.grey,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "name is required";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
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
                      const SizedBox(
                        height: 20,
                      ),
                      CustomField(
                        controller: _password,
                        hintText: "Enter your password",
                        obscureText: _obscurePassword,
                        focusNode: _passwordFocus,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/images/Password.png',
                            height: 20,
                            width: 20,
                            color: _passwordFocus.hasFocus
                                ? AppColors.primaryColor
                                : AppColors.greyColor,
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required";
                          } else if (value.length < 6) {
                            return "Password must be at least 6 characters long";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: _isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                _isChecked = value ?? false;
                              });
                            },
                            activeColor: Colors.transparent,
                            checkColor: const Color.fromARGB(255, 18, 109, 100),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            side: const BorderSide(
                              color: Colors.grey,
                              width: 2.0,
                            ),
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "I agree the medidic ",
                                    style: TextStyle(fontSize: 11),
                                  ),
                                  Text(
                                    'Term of Services ',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 18, 109, 100),
                                        fontSize: 11),
                                  ),
                                  Text(
                                    'and',
                                    style: TextStyle(fontSize: 11),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Privacy  Policy',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Color.fromARGB(255, 18, 109, 100),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 30),
                      CustomButton(
                        text: 'Sign UP',
                        onPressed: _isChecked
                            ? () {
                                if (_formKey.currentState!.validate()) {
                                  signUp();
                                }
                              }
                            : () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Please agree to the terms and conditions'),
                                  ),
                                );
                              },
                        height: 50,
                        width: 400,
                        borderRadius: 30,
                        backgroundColor: AppColors.primaryColor,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account?',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Login()),
                                  (Route<dynamic> route) =>
                                      false, // Removes all previous routes
                                );
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 38, 152, 141),
                                    fontSize: 14),
                              ))
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
