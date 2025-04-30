import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'dart:developer' show log;
import 'dart:async';

class VerifyOtp extends StatefulWidget {
  const VerifyOtp({super.key});

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  late List<FocusNode> _focusNodes;
  late List<TextEditingController> _controllers;
  Timer? _timer;
  int _secondsRemaining = 1800;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(4, (index) => FocusNode());
    _controllers = List.generate(4, (index) => TextEditingController());
    _startTimer();
  }

  void _startTimer() {
    setState(() {
      _secondsRemaining = 1800;
      _canResend = false;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _canResend = true;
        });
        timer.cancel();
      }
    });
  }

  void _onOtpChange(int index, String value) {
    if (value.isNotEmpty && index < 3) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
  }

  void _verifyOtp() {
    String otp = _controllers.map((e) => e.text).join();
    //! Add OTP verification logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("OTP Verified: $otp"),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _resendOtp() {
    //! Add resend logic here
    log("Resending OTP...");
    for (var controller in _controllers) {
      controller.clear();
    }
    FocusScope.of(context).requestFocus(_focusNodes[0]);
    _startTimer();
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: AppColors.whiteColor),
        title: const Text(
          'OTP Verification',
          style: TextStyle(color: AppColors.whiteColor),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock_outline,
                size: 80, color: AppColors.primaryColor),
            const SizedBox(height: 10),
            const Text(
              'Verify your mail',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Enter the 4-digit OTP sent to your phone.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 55,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border:
                        Border.all(color: AppColors.primaryColor, width: 1.5),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 3),
                      )
                    ],
                  ),
                  child: Center(
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      maxLength: 1,
                      cursorColor: AppColors.primaryColor,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(fontSize: 24),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        counterText: '',
                      ),
                      onChanged: (value) => _onOtpChange(index, value),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 30),
            Text(
              _canResend
                  ? "OTP expired"
                  : "Expires in ${_formatTime(_secondsRemaining)}",
              style: TextStyle(
                fontSize: 16,
                color: _canResend ? Colors.red : Colors.black87,
              ),
            ),
            if (_canResend)
              TextButton(
                onPressed: _resendOtp,
                child: const Text(
                  'Resend OTP',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: !_canResend ? _verifyOtp : null,
              icon: const Icon(
                Icons.check_circle_outline,
                color: AppColors.whiteColor,
              ),
              label: const Text(
                'Verify',
                style: TextStyle(fontSize: 18, color: AppColors.whiteColor),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 60,
                  vertical: 13,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }
}
