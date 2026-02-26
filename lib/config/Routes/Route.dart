import 'package:flutter/material.dart';
import 'package:visitorapp/screens/Login/Login_screen.dart';
import 'package:visitorapp/screens/society_admin/Manage%20User/security_guards/security_guards_screen.dart';

import '../../screens/dashboard/dashboard_screen.dart';
import '../../screens/society_admin/Manage User/manage_users_screen.dart';
import '../../screens/society_admin/Manage User/Add_flat_owner/flat_owner_list.dart';
import '../../screens/society_admin/Manage User/security_guards/edit_guards_details_form/edit_security_guards_form.dart';
import '../../screens/splash_screen/SplashScreen.dart';

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
      case RouteName.manageUsersSocietyAdmin:
        final args = setting.arguments as int;
        return MaterialPageRoute(
          builder: (_) => ManageUsersScreen(type: args),
        );

      case RouteName.FlatOwnersScreen:
        return MaterialPageRoute(builder: (context) => const FlatOwnersScreen());

      case RouteName.notificationScreen:
        return MaterialPageRoute(builder: (context) => const NotificationScreen());
      case RouteName.SecurityGuardsScreen:
        return MaterialPageRoute(builder: (context) => const SecurityGuardsScreen());
      case RouteName.EditSecurityGuardsForm:
        return MaterialPageRoute(builder: (context) => const EditSecurityGuardsForm());

      default:
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(body: Text('No Route Found'));
          },
        );
    }
  }
}
