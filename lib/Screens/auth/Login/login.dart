import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:swift_aid/Screens/auth/Forget_password/forget_passsord.dart';

import 'package:swift_aid/Screens/auth/bloc/auth_bloc.dart';
import 'package:swift_aid/Screens/auth/bloc/auth_evetns.dart';
import 'package:swift_aid/Screens/auth/components/custom_dialogue.dart';
import 'package:swift_aid/Screens/auth/components/custom_field.dart';
import 'package:swift_aid/components/circle_container.dart';
import 'package:swift_aid/components/custom_button.dart';
import 'package:swift_aid/Screens/auth/SignUp/sign.dart';
import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:swift_aid/utils/utils.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController _email;
  late TextEditingController _password;
  late FocusNode _emailFocus;
  late FocusNode _passwordFocus;

  bool _isEmailValid = false;
  bool _obscurePassword = true;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();

    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();

    _emailFocus.addListener(() {
      setState(() {});
    });

    _passwordFocus.addListener(() {
      setState(() {});
    });

    _email.addListener(_checkEmail);

    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
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

  void login() async {
    final email = _email.text.trim();
    final password = _password.text.trim();

    context.read<AuthBloc>().add(LoginEvent(email: email, password: password));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CustomDialogue();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        iconTheme: const IconThemeData(color: AppColors.whiteColor),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.13),
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                CustomField(
                  controller: _password,
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
                  hintText: "Enter your password",
                  focusNode: _passwordFocus,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "password  is required";
                    }
                    return null;
                  },
                  obscureText: _obscurePassword,
                ),
                Row(
                  children: [
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ForgetPasssord()));
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                CustomButton(
                  height: 50,
                  width: 400,
                  borderRadius: 30,
                  text: 'Login',
                  backgroundColor: AppColors.primaryColor,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      login();
                    }
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Sign(),
                          ),
                        );
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Color.fromARGB(255, 38, 152, 141),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        height: 2,
                        color: Colors.grey.withOpacity(0.3),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "OR",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        height: 2,
                        color: Colors.grey.withOpacity(0.3),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                GestureDetector(
                  child: Circle_Container(
                    icon: Image.asset('assets/images/google.jpg'),
                    height: 30,
                    width: 30,
                    color: Colors.transparent,
                  ),
                  onTap: () async {
                    context.read<AuthBloc>().add(GoogleSignInEvent());
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const CustomDialogue();
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
