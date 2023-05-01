import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peeker/utils/assets_manager.dart';
import 'package:peeker/utils/color_manager.dart';

import '../../utils/const.dart';
import '../Home/home.dart';
import '../auth/Login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Rx<User?> _user;

  void onReady() {
    _user = Rx<User?>(fAuth.currentUser);
    _user.bindStream(fAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    Timer(const Duration(seconds: 2), () {
      if (user == null) {
        Get.offAll(() => const LoginScreen());
      } else {
        Get.offAll(() => const HomeScreen());
      }
    });
  }

  @override
  void initState() {
    super.initState();
    onReady();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryColor,
      body: Center(
        child: Container(
          child: Image.asset(
            ImageAssets.logo,
          ),
        ),
      ),
    );
  }
}
