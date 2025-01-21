import 'package:swift_aid/Screens/auth/components/custom_field.dart';
import 'package:swift_aid/Screens/auth/Login/login.dart';
import 'package:swift_aid/components/custom_button.dart';
import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  late TextEditingController _newPassword;
  late TextEditingController _confirmnewPassword;
  late FocusNode _newFocus;
  late FocusNode _confirmFocus;

  bool _obscurePassword = true;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _newPassword = TextEditingController();
    _confirmnewPassword = TextEditingController();

    _newFocus = FocusNode();
    _confirmFocus = FocusNode();

    _newFocus.addListener(() {
      setState(() {});
    });

    _confirmFocus.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    _newFocus.dispose();
    _confirmFocus.dispose();
    _newPassword.dispose();
    _confirmnewPassword.dispose();
    super.dispose();
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
          'Reset Password',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        iconTheme: const IconThemeData(color: AppColors.whiteColor),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.13),
                CustomField(
                  controller: _newPassword,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/Password.png',
                      height: 20,
                      width: 20,
                      color: _newFocus.hasFocus
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
                  hintText: " New  password",
                  focusNode: _newFocus,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return " new password  is required";
                    }
                    return null;
                  },
                  obscureText: _obscurePassword,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                CustomField(
                  controller: _confirmnewPassword,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/Password.png',
                      height: 20,
                      width: 20,
                      color: _confirmFocus.hasFocus
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
                  hintText: " confirm new password",
                  focusNode: _confirmFocus,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return " confirm  password  is required";
                    }
                    return null;
                  },
                  obscureText: _obscurePassword,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                CustomButton(
                  text: 'Reset',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Reseting password')),
                      );
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const Login()));
                    }
                  },
                  height: 50,
                  width: 300,
                  borderRadius: 30,
                  backgroundColor: AppColors.primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
