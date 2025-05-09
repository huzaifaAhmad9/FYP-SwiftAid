import 'package:swift_aid/bloc/hospital_auth_bloc/hospital_auth_event.dart';
import 'package:swift_aid/bloc/hospital_auth_bloc/hospital_auth_state.dart';
import 'package:swift_aid/bloc/hospital_auth_bloc/hospital_auth_bloc.dart';
import 'package:swift_aid/Screens/auth/components/custom_field.dart';
import 'package:swift_aid/components/responsive_sized_box.dart';
import 'package:swift_aid/Screens/auth/SignUp/verify_otp.dart';
import 'package:swift_aid/bloc/auth_bloc/auth_evetns.dart';
import 'package:swift_aid/bloc/auth_bloc/auth_state.dart';
import 'package:swift_aid/bloc/auth_bloc/auth_bloc.dart';
import 'package:swift_aid/components/custom_button.dart';
import 'package:swift_aid/Screens/auth/Login/login.dart';
import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_aid/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:developer' show log;

class Sign extends StatefulWidget {
  const Sign({super.key});

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  bool isServicesSelected = true;
  int _selectedIndex = 0;

  // List of pages
  final List<Widget> _pages = [
    const Patient(),
    const Doctor(),
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
            'SignUp',
            style: TextStyle(color: AppColors.secondaryColor),
          ),
          centerTitle: true,
          backgroundColor: AppColors.primaryColor,
          iconTheme: const IconThemeData(color: AppColors.secondaryColor),
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

//! Patient
class Patient extends StatefulWidget {
  const Patient({super.key});

  @override
  State<Patient> createState() => _PatientState();
}

class _PatientState extends State<Patient> {
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
    customDialogue();
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
                    context,
                    MaterialPageRoute(
                        builder: (_) => const VerifyOtp(
                              userType: 'user',
                            )));
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                                    color: Color.fromARGB(255, 18, 109, 100),
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
                              (Route<dynamic> route) => false,
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
    );
  }
}

//! Hospital
class Doctor extends StatefulWidget {
  const Doctor({super.key});

  @override
  State<Doctor> createState() => _DoctorState();
}

class _DoctorState extends State<Doctor> {
  late TextEditingController _name;
  late TextEditingController _email;
  late TextEditingController _password;
  late TextEditingController _number;
  late FocusNode _nameFocus;
  late FocusNode _emailFocus;
  late FocusNode _passwordFocus;
  late FocusNode _numberFocus;
  bool _obscurePassword = true;
  bool _isEmailValid = false;
  bool _isChecked = false;

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
                    context,
                    MaterialPageRoute(
                        builder: (_) => const VerifyOtp(userType: 'hospital')));
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

  void signUp() async {
    final email = _email.text.trim();
    final password = _password.text.trim();
    final name = _name.text.trim();
    final number = _number.text.trim();

    context.read<HospitalAuthBloc>().add(RegisterHospital(
        email: email, password: password, name: name, phone: number));
    customDialogue();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    _number = TextEditingController();

    _nameFocus = FocusNode();
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
    _numberFocus = FocusNode();
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
    _numberFocus.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _number.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _numberFocus.dispose();
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
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  CustomField(
                    controller: _name,
                    hintText: "Enter name",
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
                    hintText: 'Enter email',
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
                    hintText: "Enter password",
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
                    height: 20,
                  ),
                  CustomField(
                    controller: _number,
                    hintText: "Enter Number",
                    obscureText: false,
                    focusNode: _numberFocus,
                    prefixIcon: Icon(
                      CupertinoIcons.phone_circle,
                      color: _numberFocus.hasFocus
                          ? AppColors.primaryColor
                          : Colors.grey,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Number is required";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
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
                                    color: Color.fromARGB(255, 18, 109, 100),
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
                              (Route<dynamic> route) => false,
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
