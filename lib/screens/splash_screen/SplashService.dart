import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../config/Routes/RouteName.dart';
import '../../secure storage/user_info.dart';
import '../../model/VerifyOtpResponse.dart';

class SplashService {
  void isLogin(BuildContext context) async {
    Timer(
      const Duration(seconds: 3),
      () async {
        VerifyOtpResponse? userInfo = await UserInfoSecureStorage.getUserInfo();

        if (userInfo != null && userInfo.status == true) {
          String targetRoute;
          if (userInfo.roleId == 1) {
            targetRoute = RouteName.DeveloperAdminDashboardScreen;
          } else if (userInfo.roleId == 2) {
            targetRoute = RouteName.SocietyAdminDashboardScreen;
          } else if (userInfo.roleId == 3) {
            targetRoute = RouteName.dashboardScreen;
          } else {
            targetRoute = RouteName.loginScreen;
          }

          Navigator.pushNamedAndRemoveUntil(
            context,
            targetRoute,
            (route) => false,
          );
        } else {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteName.loginScreen,
            (route) => false,
          );
        }
      },
    );
  }
}
