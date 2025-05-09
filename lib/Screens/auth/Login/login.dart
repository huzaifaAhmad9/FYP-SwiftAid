import 'package:swift_aid/Screens/auth/Forget_password/forget_passsord.dart';
import 'package:swift_aid/bloc/hospital_auth_bloc/hospital_auth_event.dart';
import 'package:swift_aid/bloc/hospital_auth_bloc/hospital_auth_state.dart';
import 'package:swift_aid/bloc/hospital_auth_bloc/hospital_auth_bloc.dart';
import 'package:swift_aid/Screens/hospital/hospital_dashboard.dart';
import 'package:swift_aid/Screens/auth/components/custom_field.dart';
import 'package:swift_aid/components/responsive_sized_box.dart';
import 'package:swift_aid/Screens/Main_Screens/main_home.dart';
import 'package:swift_aid/components/circle_container.dart';
import 'package:swift_aid/bloc/auth_bloc/auth_evetns.dart';
import 'package:swift_aid/bloc/auth_bloc/auth_state.dart';
import 'package:swift_aid/bloc/auth_bloc/auth_bloc.dart';
import 'package:swift_aid/components/custom_button.dart';
import 'package:swift_aid/Screens/auth/SignUp/sign.dart';
import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_aid/utils/utils.dart';
import 'package:flutter/material.dart';
import 'dart:developer' show log;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isServicesSelected = true;
  int _selectedIndex = 0;

  // List of pages
  final List<Widget> _pages = [
    const Patient(),
    const Hospital(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      isServicesSelected = (index == 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

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
        body: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.035),
              Container(
                height: 48,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.lightGrey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _onItemTapped(0),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: isServicesSelected
                              ? const EdgeInsets.all(5.0)
                              : EdgeInsets.zero,
                          decoration: BoxDecoration(
                            color: isServicesSelected
                                ? AppColors.primaryColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(13),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 20),
                          child: Center(
                            child: Text(
                              'User',
                              style: TextStyle(
                                fontSize: 14,
                                color: isServicesSelected
                                    ? Colors.white
                                    : AppColors.lightGrey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _onItemTapped(1),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: !isServicesSelected
                              ? const EdgeInsets.all(5.0)
                              : EdgeInsets.zero,
                          decoration: BoxDecoration(
                            color: !isServicesSelected
                                ? AppColors.primaryColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(13),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 20),
                          child: Center(
                            child: Text(
                              'Hospital',
                              style: TextStyle(
                                fontSize: 14,
                                color: !isServicesSelected
                                    ? Colors.white
                                    : AppColors.lightGrey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _pages[_selectedIndex],
              ),
            ],
          ),
        ));
  }
}

//! Patient ---->
class Patient extends StatefulWidget {
  const Patient({super.key});

  @override
  State<Patient> createState() => _PatientState();
}

class _PatientState extends State<Patient> {
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const MainHome()));
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

  void login() async {
    final email = _email.text.trim();
    final password = _password.text.trim();

    context.read<AuthBloc>().add(LoginEvent(email: email, password: password));
    customDialogue();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
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
                                builder: (_) => const ForgetPasssord(
                                      userType: 'user',
                                    )));
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
                    customDialogue();
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

//! Hospital ---->
class Hospital extends StatefulWidget {
  const Hospital({super.key});

  @override
  State<Hospital> createState() => _HospitalState();
}

class _HospitalState extends State<Hospital> {
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

  void customDialogue() {
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

              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const HospitalDashboard()));
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

  void login() async {
    final email = _email.text.trim();
    final password = _password.text.trim();

    context
        .read<HospitalAuthBloc>()
        .add(LoginHospital(email: email, password: password));
    customDialogue();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
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
                                builder: (_) => const ForgetPasssord(
                                      userType: 'hospital',
                                    )));
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildDialog(BuildContext context,
    {required Widget content, required String title}) {
  return AlertDialog(
    title: Text(title),
    content: content,
  );
}
