// ignore_for_file: use_build_context_synchronously

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:must_do/core/constants/text_styles.dart';
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
  @override
  void didChangeDependencies() {
    _initialSetup();
    super.didChangeDependencies();
  }

  _initialSetup() async {
    ///
    /// If not connected to internet, show an alert dialog
    /// to activate the network connection.
    ///
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      Get.dialog(
        const AlertDialog(
          title: Text('Network Error'),
          content: Text('Connection to internet failed!'),
        ),
      );
      return;
    }
  }

  final _authService = locator<AuthService>();

  naviagetToNextScreen() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    if (_authService.isLogin) {
      Get.off(() => const HomeScreen());
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Text(
            'Lets get the things done...',
            style: heading1.copyWith(color: Colors.black54),
          ),
        ),
      ),
    );
  }
}
