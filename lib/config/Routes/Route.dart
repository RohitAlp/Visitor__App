import 'package:flutter/material.dart';
import 'package:visitorapp/screens/Login/Login_screen.dart';

import '../../screens/developer_admin_dashboard/developer_admin_dashboard_screen.dart';
import '../../screens/profile/profile.dart';
import '../../screens/resident_dashboard/resident_dashboard_screen.dart';
import '../../screens/society_admin_dashboard/Manage Property/Manage Flats/flat_list.dart';
import '../../screens/society_admin_dashboard/Manage Property/Manage Tower/Add_tower.dart';
import '../../screens/society_admin_dashboard/Manage Property/Manage Tower/add_tower_form.dart';
import '../../screens/society_admin_dashboard/Manage Property/manage_amanities/amanities_screen.dart';
import '../../screens/society_admin_dashboard/Manage Property/manage_floors/floors_screens/manage_floors_screen.dart';
import '../../screens/society_admin_dashboard/Manage Property/manage_wings/edit_wing_form/edit_wing_form.dart';
import '../../screens/society_admin_dashboard/Manage Property/manage_wings/manage_wing_screen.dart';
import '../../screens/society_admin_dashboard/Manage User/Add_flat_owner/Add_flat_owner_form.dart';
import '../../screens/society_admin_dashboard/Manage User/Add_flat_owner/flat_owner_list.dart';
import '../../screens/society_admin_dashboard/Manage User/Vendors/venders_screen.dart';
import '../../screens/society_admin_dashboard/Manage User/security_guards/edit_guards_details_form/edit_security_guards_form.dart';
import '../../screens/society_admin_dashboard/Manage User/security_guards/security_guards_screen.dart';
import '../../screens/society_admin_dashboard/manage_users_property_screen.dart';
import '../../screens/society_admin_dashboard/service_requests/service_request_list/service_request_list_screen.dart';
import '../../screens/society_admin_dashboard/society_admin_dashboard_screen.dart';
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
        case RouteName.ManageTowersScreen:
        return MaterialPageRoute(builder: (context) => const ManageTowersScreen());
      case RouteName.ServiceRequestListScreen:
        return MaterialPageRoute(builder: (context) => ServiceRequestListScreen());
      case RouteName.AddTowerForm:
        return MaterialPageRoute(builder: (context) => const AddTowerForm());
        case RouteName.ManageFlatsScreen:
        return MaterialPageRoute(builder: (context) => const ManageFlatsScreen());
      case RouteName.SocietyAdminDashboardScreen:
        return MaterialPageRoute(builder: (context) =>   const SocietyAdminDashboardScreen());

      case RouteName.notificationScreen:
        return MaterialPageRoute(builder: (context) => const NotificationScreen());
      case RouteName.SecurityGuardsScreen:
        return MaterialPageRoute(builder: (context) => const SecurityGuardsScreen());
      case RouteName.EditSecurityGuardsForm:
        return MaterialPageRoute(builder: (context) => const EditSecurityGuardsForm());
      case RouteName.VendorsScreens:
        return MaterialPageRoute(builder: (context) => const VendorsScreens());
      case RouteName.ManageWingScreen:
        return MaterialPageRoute(builder: (context) => const ManageWingScreen());
      case RouteName.EditWingForm:
        return MaterialPageRoute(builder: (context) => const EditWingForm());
      case RouteName.ManageFloorsScreen:
        return MaterialPageRoute(builder: (context) => const ManageFloorsScreen());
      case RouteName.ManageAmanitiesScreen:
        return MaterialPageRoute(builder: (context) => const ManageAmanitiesScreen());
      case RouteName.DeveloperAdminDashboardScreen:
        return MaterialPageRoute(builder: (context) => const DeveloperAdminDashboardScreen());


        case RouteName.AddFlatOwnerForm:
      case RouteName.Profile:
        return MaterialPageRoute(builder: (context) => const Profile());
      case RouteName.AddFlatOwnerForm:
        final args = setting.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (context) => AddFlatOwnerForm(
            initialName: args?['name'] as String?,
            initialMobile: args?['mobile'] as String?,
            initialFlatNumber: args?['flatNumber'] as String?,
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(body: Text('No Route Found'));
          },
        );
    }
  }
}
