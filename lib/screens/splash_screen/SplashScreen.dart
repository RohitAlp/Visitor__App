import 'package:flutter/material.dart';
import 'SplashService.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  @override
  void initState() {
    super.initState();
    SplashService().isLogin(context);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body:  Center(
        child: Image.asset(
          'assets/image/Applogo.png',
          height: 400,
          width: 300,
        ),
      ),
    );
  }
}
