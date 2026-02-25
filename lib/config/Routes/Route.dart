import 'package:flutter/material.dart';
import 'package:visitorapp/screens/Login/Login_screen.dart';

import '../../screens/dashboard/dashboard_screen.dart';
import '../../screens/splash_screen/SplashScreen.dart';
import '../../screens/Notice/notice.dart';
import '../../screens/payment/payment.dart';
import '../../screens/profile/profile.dart';
import '../../screens/services/services.dart';
import '../../screens/Notification/Notificarion.dart';

import '../../screens/settings/settings_screen.dart';
import 'RouteName.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (context) => Splashscreen());
      case RouteName.loginScreen:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case RouteName.settingsScreen:
        return MaterialPageRoute(builder: (context) => SettingsScreen());
      case RouteName.dashboardScreen:
        return MaterialPageRoute(builder: (context) => DashboardScreen());

      case RouteName.notificationScreen:
        return MaterialPageRoute(builder: (context) => const NotificationScreen());

      default:
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(body: Text('No Route Found'));
          },
        );
    }
  }
}
