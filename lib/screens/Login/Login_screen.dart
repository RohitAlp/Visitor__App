import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/Routes/RouteName.dart';
import '../../constants/app_colors.dart';
import '../../constants/utils.dart';
import '../../widgets/CommonTextField.dart';
import '../../widgets/common_otp_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final mobileController = TextEditingController();
  int _secondsRemaining = 30;
  Timer? _timer;
  bool _canResend = false;
  bool _otpSent = false;
  String _enteredOtp = "";
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _sendOtp() {
    if (mobileController.text.length < 10) {
      Utils.showToast(
        context,
        message: "Enter valid mobile number",
      );
      return;
    }

    setState(() {
      _otpSent = true;
    });

    _startTimer();
  }

  void _verifyOtp() {
    if (_enteredOtp.isEmpty || _enteredOtp.length < 4) {
      Utils.showToast(
        context,
        message: "Please enter OTP",
        backgroundColor: Colors.red,
      );
      return;
    }
      Navigator.pushNamed(
      context,
      RouteName.manageUsersSocietyAdmin,
      arguments: 1,
    );
  }

  void _startTimer() {
    _secondsRemaining = 30;
    _canResend = false;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        setState(() {
          _canResend = true;
        });
        timer.cancel();
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  void _onResend() {
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24),
                Center(
                  child: Image.asset(
                    'assets/image/Applogo.png',
                    height: 120,
                    width: 200,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Welcome Onboard!",
                  style: TextStyle(
                    color: AppColors.appPrimaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Login via otp",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20),

                CommonTextField(
                  hintText: "Enter mobile number",
                  prefixIcon: Icons.phone,
                  iconColor: AppColors.appPrimaryColor,
                  controller: mobileController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  readOnly: _otpSent,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Mobile number is required";
                    }
                    if (value.length < 10) {
                      return "Enter valid mobile number";
                    }
                    return null;
                  },
                ),
                if (_otpSent) ...[
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CommonOtpField(
                      length: 4,
                      onCompleted: (otp) {
                        _enteredOtp = otp;
                      },
                    ),
                  ),
                  Column(
                    children: [
                      /// ⏱️ TIMER
                      Text(
                        "00:${_secondsRemaining.toString().padLeft(2, '0')}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.appPrimaryColor,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Yet to receive OTP? ",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                          ),
                          GestureDetector(
                            onTap: _canResend ? _onResend : null,
                            child: Text(
                              "Resend OTP",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: _canResend
                                    ? AppColors.appPrimaryColor
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
                SizedBox(height: 30),
                Center(
                  child: InkWell(
                    onTap: () {
                      if (!_otpSent) {
                        _sendOtp();
                      } else {
                        _verifyOtp();
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                        color: AppColors.appPrimaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _otpSent ? 'Verify OTP' : 'Send OTP',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
