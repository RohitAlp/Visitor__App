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

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final mobileController = TextEditingController();
  late AnimationController _rotationController;
  int _secondsRemaining = 30;
  Timer? _timer;
  bool _canResend = false;
  bool _otpSent = false;
  String _enteredOtp = "";
  @override
  void initState() {
    super.initState();

    _imageTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _currentImageIndex =
            (_currentImageIndex + 1) % _images.length;
      });
    });
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
  int _currentImageIndex = 0;
  Timer? _imageTimer;

  final List<String> _images = [
    'assets/image/tower1.png',
    'assets/image/tower2.png',
    'assets/image/tower3.png',
  ];
  @override
  void dispose() {
    _imageTimer?.cancel();
    _rotationController.dispose();
    _timer?.cancel();
    mobileController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SizedBox.expand(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 800),
                child: Image.asset(
                  _images[_currentImageIndex],
                  key: ValueKey(_images[_currentImageIndex]),
                  fit: BoxFit.cover, // 👈 fills & crops properly
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
          ),

          /// 🔘 Let's Start Button
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _openLoginBottomSheet,
                child: const Text(
                  "Let's Start →",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  void _openLoginBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            top: 20,
          ),
          child:SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Rutuja!",
                  style: TextStyle(
                    color: AppColors.appPrimaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Login",
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
                  SizedBox(height: 15),
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
                      Text(
                        "00:${_secondsRemaining.toString().padLeft(2, '0')}",
                        style: TextStyle(
                          fontSize: 14,
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
                SizedBox(height: 15),
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
                      height: 40,
                      width: 170,
                      decoration: BoxDecoration(
                        color: AppColors.appPrimaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _otpSent ? 'Verify OTP' : 'Login',
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
        );
      },
    );
  }
}
