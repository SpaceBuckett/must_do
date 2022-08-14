// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:must_do/core/locator.dart';
import 'package:must_do/core/services/auth_services.dart';
import 'package:must_do/screens/auth/signup/signup_screen1.dart';
import 'package:must_do/screens/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _authService = locator<AuthService>();

  naviagetToNextScreen() async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (_authService.isLogin) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => SignUpScreenOne()),
          (route) => false);
    }
  }

  @override
  void initState() {
    naviagetToNextScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 200,
          width: 200,
          color: Colors.grey,
        ),
      ),
    );
  }
}
