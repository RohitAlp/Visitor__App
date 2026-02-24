import 'package:flutter/material.dart';
import 'package:visitorapp/screens/Login/Login_screen.dart';

import '../../screens/dashboard/dashboard_screen.dart';
import '../../screens/Notice/notice.dart';
import '../../screens/payment/payment.dart';
import '../../screens/profile/profile.dart';
import '../../screens/services/services.dart';
import '../../screens/splash_screen/view/SplashScreen.dart';
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

      case RouteName.paymentScreen:
        return MaterialPageRoute(builder: (context) => const Payment());
      case RouteName.noticeScreen:
        return MaterialPageRoute(builder: (context) => const Notice());
      case RouteName.servicesScreen:
        return MaterialPageRoute(builder: (context) => const Services());
      case RouteName.profileScreen:
        return MaterialPageRoute(builder: (context) => const Profile());

      default:
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(body: Text('No Route Found'));
          },
        );
    }
  }
}
