import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../../config/Routes/RouteName.dart';
import '../../constants/app_colors.dart';
import '../../constants/constant.dart';
import '../../constants/utils.dart';
import '../../controller/login_controller.dart';
import '../../model/LoginResponse.dart';
import '../../model/VerifyOtpResponse.dart';
import '../../widgets/common_otp_field.dart';

class OtpScreen extends StatefulWidget {
  final String mobileNumber;

  const OtpScreen({super.key, required this.mobileNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  int _secondsRemaining = 30;
  Timer? _timer;
  bool _canResend = false;
  String _enteredOtp = "";

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _secondsRemaining = 30;
    _canResend = false;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        setState(() => _canResend = true);
        timer.cancel();
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  void _verifyOtp() {
    if (_enteredOtp.length < 6) {
      Utils.showToast(
        context,
        message: "Please enter valid OTP",
        backgroundColor: Colors.red,
      );
      return;
    } else {
      FocusManager.instance.primaryFocus?.unfocus();

      _verifyOtpAPI();
    }
  }

  Future<void> _verifyOtpAPI() async {
    if (await Utils.isConnected()) {
      final box = GetStorage();

      bool _isLoading = true;
      Utils.onLoading(context);
      Map<String, dynamic> data = {
        "mobileNumber": widget.mobileNumber, //"7770028773",
        "otp": _enteredOtp, //"123456"
      };

      LoginController loginUserController = LoginController();
      try {
        final response = await loginUserController.verifyOtp(data);

        if (response != null) {
          VerifyOtpResponse verifyOtpResponse = VerifyOtpResponse.fromJson(
            response.data,
          );
          if (verifyOtpResponse.status == true) {
            String loginResponse = jsonEncode(response.data);
            box.write(Constant.loginResponse, loginResponse);
            box.write(Constant.userId, verifyOtpResponse.userId);
            box.write(Constant.roleId, verifyOtpResponse.roleId);
            box.write(Constant.tokenMobile, verifyOtpResponse.token);

            Utils.showToast(context, message: '${verifyOtpResponse.message}');
            Navigator.pop(context);
            _isLoading = false;
            Navigator.pushNamed(
              context,
              // RouteName.manageUsersSocietyAdmin,
              // arguments: 2,
              RouteName.dashboardScreen,
            );
          } else {
            if (verifyOtpResponse.message ==
                "Too many attempts. Account locked for 30 minutes.") {
              Navigator.pop(context);
              _isLoading = false;
              Navigator.pushNamed(context, RouteName.loginScreen);
            }
            Utils.showToast(context, message: '${verifyOtpResponse.message}');
          }
        } else {
          Utils.showToast(context, message: 'Something went wrong!');
          print(response);
        }
      } catch (e) {
        Utils.showToast(context, message: 'Something went wrong!');
        print(e);
      } finally {
        if (_isLoading) {
          Navigator.pop(context);
        }
      }
    } else {
      Utils.showToast(context, message: Constant.internetConMsg);
    }
  }

  void _resendOtp() async {
    await _resentOtp(context);
    /*_startTimer();

    Utils.showToast(context, message: "OTP Resent");*/
  }

  Future<void> _resentOtp(BuildContext context) async {
    if (await Utils.isConnected()) {
      bool _isLoading = true;
      Utils.onLoading(context);
      String mobileNo = widget.mobileNumber;

      Map<String, dynamic> data = {
        "mobileNumber": mobileNo, // "7770028773"
      };

      LoginController loginUserController = LoginController();
      try {
        final response = await loginUserController.getLogin(data);

        if (response != null) {
          LoginResponse loginUser = LoginResponse.fromJson(response.data);

          if (loginUser.status == true ) {
            // Utils.showToast(context, message: '${loginUser.message}');

            Navigator.pop(context);
            _isLoading = false;

            _startTimer();

            Utils.showToast(context, message: "OTP Resent");
          } else {
            Utils.showToast(context, message: '${loginUser.message}');
          }
        } else {
          Utils.showToast(context, message: 'Something went wrong!');
          print(response);
        }
      } catch (e) {
        Utils.showToast(context, message: 'Something went wrong!');
        print(e);
      } finally {
        if (_isLoading) {
          Navigator.pop(context);
        }
      }
    } else {
      Utils.showToast(context, message: Constant.internetConMsg);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              CupertinoIcons.back,
              color: Colors.black, // change if needed
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            "OTP Verification",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "We have sent a verification code to",
                  style: TextStyle(
                    color: AppColors.appPrimaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Center(
                child: Text(
                  " +91-${widget.mobileNumber}",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 60),

              /// OTP Field
              CommonOtpField(
                length: 6,
                onCompleted: (otp) {
                  _enteredOtp = otp;
                },
              ),

              const SizedBox(height: 20),

              /// OTP Timer + Resend (Single Line)
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn't get the OTP? ",
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    GestureDetector(
                      onTap: _canResend ? _resendOtp : null,
                      child: Row(
                        children: [
                          Text(
                            "Resend OTP",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _canResend
                                  ? AppColors.appPrimaryColor
                                  : Colors.grey,
                            ),
                          ),

                          if (!_canResend) ...[
                            const SizedBox(width: 4),
                            Text(
                              "in 00:${_secondsRemaining.toString().padLeft(2, '0')}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppColors.appPrimaryColor,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Go back to login method",
                    style: TextStyle(
                      color: AppColors.appPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),

              /// Verify Button
              InkWell(
                onTap: _verifyOtp,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.appPrimaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "Verify OTP",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
