import 'package:flutter/material.dart';

import '../../screens/splash_screen/view/SplashScreen.dart';
import 'RouteName.dart';

class Routes{
static Route<dynamic> generateRoute(RouteSettings setting){
  switch (setting.name){
    case RouteName.splashScreen:
      return  MaterialPageRoute(builder: (context) => Splashscreen(),);

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