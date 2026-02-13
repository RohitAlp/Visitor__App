import 'package:flutter/material.dart';
import 'package:visitorapp/screens/Login/Login_screen.dart';

import '../../screens/splash_screen/view/SplashScreen.dart';
import 'RouteName.dart';
//
class Routes{
static Route<dynamic> generateRoute(RouteSettings setting){
  switch (setting.name){
    case RouteName.splashScreen:
      return  MaterialPageRoute(builder: (context) => Splashscreen(),);
    case RouteName.loginScreen:
      return  MaterialPageRoute(builder: (context) => LoginScreen(),);

    default:
      return MaterialPageRoute(builder: (context) {
        return Scaffold(
          body: Text('No Route Found'),
        );
      }
      );
  }
}
}