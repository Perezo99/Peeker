import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peeker/utils/color_manager.dart';
import 'package:peeker/utils/route_manager.dart';
import 'package:peeker/views/Splash/splash_screen.dart';
import 'views/auth/Login/login_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Peeker',
      onGenerateRoute: RouteGenerator.getRoute,
      theme: ThemeData(
        primaryColor: ColorManager.primaryColor,
        scaffoldBackgroundColor: ColorManager.primaryColor,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
