import 'package:swift_aid/Screens/auth/sign.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController _email;
  late TextEditingController _password;
  bool _isEmailValid = false;
  bool _obscurePassword = true;
  bool _isPasswordValid = true;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();

    _email.addListener(_checkEmail);

    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
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

  void _checkPassword() {
    setState(() {
      _isPasswordValid = _password.text == "123456";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Image.asset(
                  "assets/images/Button.png",
                ),
                iconSize: 40.0,
              ),
              const SizedBox(
                width: 100,
              ),
              const Text(
                "Login",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const Spacer()
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(children: [
              TextField(
                cursorColor: const Color.fromARGB(255, 18, 109, 100),
                controller: _email,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/Email.png',
                      height: 20,
                      width: 20,
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
                controller: _password,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/Password.png',
                      height: 20,
                      width: 20,
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
                      color: _isPasswordValid
                          ? Colors.grey.withOpacity(0.1)
                          : Colors.red,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: _isPasswordValid
                          ? Colors.grey.withOpacity(0.1)
                          : Colors.red,
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
              const SizedBox(height: 5),
              Row(
                children: [
                  !_isPasswordValid
                      ? const Text(
                          "The password you enter is wrong",
                          style: TextStyle(fontSize: 9, color: Colors.red),
                        )
                      : const SizedBox(
                          width: 180,
                        ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    'Forgot Password?',
                    style: TextStyle(
                        color: Color.fromARGB(255, 38, 152, 141), fontSize: 11),
                  )
                ],
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  _checkPassword();
                  if (_isPasswordValid) {
                  } else {}
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
                      'Login',
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
                    'Don\'t have an account?',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Sign()));
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Color.fromARGB(255, 38, 152, 141),
                            fontSize: 12),
                      ))
                ],
              ),
              const SizedBox(
                height: 30,
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
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(30),
                      ),
                      border: Border.all(color: Colors.grey)),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/google.jpg',
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(
                        width: 60,
                      ),
                      const Text(
                        'Sign in with google',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(30),
                      ),
                      border: Border.all(color: Colors.grey)),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.mobile_friendly,
                        size: 20,
                        color: Color.fromARGB(255, 38, 152, 141),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        'Sign in with Ph-Number',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ]),
          )
        ],
      ),
    ));
  }
}
