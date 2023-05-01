import 'dart:io';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:peeker/views/Comment/comment_screen.dart';
import 'package:peeker/views/Home/home.dart';
import 'package:peeker/views/auth/Login/login_screen.dart';
import 'package:peeker/views/auth/Signup/signup_screen.dart';

class Routes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String confirm = '/confirm';
  static const String comment = '/comment';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.login:
        return PageTransition(
          child: LoginScreen(),
          type: PageTransitionType.leftToRight,
          duration: Duration(milliseconds: 1000),
          reverseDuration: Duration(milliseconds: 1000),
        );

      case Routes.signup:
        return PageTransition(
          child: SignupScreen(),
          type: PageTransitionType.rightToLeft,
          duration: Duration(milliseconds: 1000),
          reverseDuration: Duration(milliseconds: 1000),
        );

      case Routes.home:
        return PageTransition(
          child: HomeScreen(),
          type: PageTransitionType.leftToRight,
          duration: Duration(milliseconds: 1000),
          reverseDuration: Duration(milliseconds: 1000),
        );
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text('No Page Found'),
              ),
              body: const Center(
                child: Text('No Page Found'),
              ),
            ));
  }
}
