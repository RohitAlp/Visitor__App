import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:visitorapp/screens/Login/Otp_screen.dart';

import '../../config/Routes/RouteName.dart';
import '../../constants/app_colors.dart';
import '../../constants/constant.dart';
import '../../constants/utils.dart';
import '../../controller/login_controller.dart';
import '../../model/LoginResponse.dart';
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
  bool _otpSent = false;

  bool _showStartButton = true;
  @override
  void initState() {
    super.initState();
    _imageTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!mounted) return;

      setState(() {
        _currentImageIndex = (_currentImageIndex + 1) % _images.length;
      });
    });
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
    mobileController.dispose();
    super.dispose();
  }

  Future<void> _userLogin(BuildContext context) async {
    if (await Utils.isConnected()) {
      bool _isLoading = true;
      Utils.onLoading(context);
      String mobileNo = mobileController.text;

      Map<String, dynamic> data = {
        "mobileNumber": mobileNo, // "7770028773"
      };

      LoginController loginUserController = LoginController();
      try {
        final response = await loginUserController.getLogin(data);

        if (response != null) {
          LoginResponse loginUser = LoginResponse.fromJson(response.data);

          if (loginUser.status == true) {
            Utils.showToast(context, message: '${loginUser.message}');

            Navigator.pop(context);
            _isLoading = false;

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => OtpScreen(mobileNumber: mobileController.text),
              ),
            );
          } else {
            Utils.showToast(context, message: '${loginUser.message}');
            print(loginUser.message);
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: SizedBox.expand(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 800),
                  child: Image.asset(
                    _images[_currentImageIndex],
                    key: ValueKey(_images[_currentImageIndex]),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
            ),

            if (_showStartButton)
              Positioned(
                bottom: 60,
                left: 0,
                right: 0,
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.appPrimaryColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        mobileController.clear();
                        _showStartButton = false;
                      });

                      _openLoginBottomSheet();
                    },
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
      ),
    );
  }

  void _openLoginBottomSheet() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                top: 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Smart Living Starts Here",
                      style: TextStyle(
                        color: AppColors.appPrimaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),

                    CommonTextField(
                      hintText: "Enter mobile number",
                      prefixIcon: Icons.phone,
                      iconColor: AppColors.appPrimaryColor,
                      controller: mobileController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 10,
                    ),

                    const SizedBox(height: 20),

                    Center(

                      child: InkWell(
                        onTap: () {
                          if (mobileController.text.length < 10) {
                            Utils.showToast(
                              context,
                              message: "Enter valid mobile number",
                            );
                            return;
                          } else {
                            // Navigator.pop(context);

                            FocusManager.instance.primaryFocus?.unfocus();

                            _userLogin(context);
                          }
                        },



                        child: SafeArea(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: AppColors.appPrimaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Continue',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
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
      },
    );
    setState(() {
      _showStartButton = true;
    });
  }
}
