// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:swift_aid/Screens/personal_details/personal_detail.dart';

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
      _isEmailValid = _isValidEmail(_email.text);
    });
  }

  bool _isValidEmail(String email) {
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegExp.hasMatch(email);
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 30),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Image.asset(
                  "assets/images/Button.png",
                ),
                iconSize: 40.0,
              ),
              const SizedBox(width: 100),
              const Text(
                "SignUp",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const Spacer()
            ],
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                TextField(
                  cursorColor: const Color.fromARGB(255, 18, 109, 100),
                  controller: _name,
                  focusNode: _nameFocus,
                  decoration: InputDecoration(
                    hintText: 'Enter your name',
                    hintStyle:
                        const TextStyle(fontSize: 12, color: Colors.grey),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/images/user.png',
                        height: 20,
                        width: 20,
                        color: _nameFocus.hasFocus
                            ? const Color.fromARGB(255, 18, 109, 100)
                            : Colors.grey,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 5),
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.1),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.1),
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.1),
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  cursorColor: const Color.fromARGB(255, 18, 109, 100),
                  controller: _email,
                  focusNode:
                      _emailFocus, // Make sure to associate the correct FocusNode
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    hintStyle:
                        const TextStyle(fontSize: 12, color: Colors.grey),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/images/Email.png',
                        height: 20,
                        width: 20,
                        color: _emailFocus.hasFocus
                            ? const Color.fromARGB(255, 18, 109, 100)
                            : Colors.grey,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 5),
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.1),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.1),
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.1),
                        width: 2.0,
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
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  cursorColor: const Color.fromARGB(255, 18, 109, 100),
                  focusNode: _passwordFocus,
                  controller: _password,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    hintStyle:
                        const TextStyle(fontSize: 12, color: Colors.grey),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/images/Password.png',
                        height: 20,
                        width: 20,
                        color: _passwordFocus.hasFocus
                            ? const Color.fromARGB(255, 18, 109, 100)
                            : Colors.grey,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.1),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.1),
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.1),
                        width: 2.0,
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
                  ),
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
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const PersonalDetail()));
                  },
                  child: Container(
                    height: 50,
                    width: 400,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Color.fromARGB(255, 18, 109, 100),
                    ),
                    child: const Center(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
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
                        onPressed: () {},
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              color: Color.fromARGB(255, 38, 152, 141),
                              fontSize: 12),
                        ))
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
