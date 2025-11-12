import 'dart:async';

import 'package:first_flutter_v1/core/config/routes_name.dart';
import 'package:first_flutter_v1/features/auth/data/services/session_controller.dart';
import 'package:flutter/material.dart';

class SplashService {
  Future<void> isLogin(BuildContext context) async {
    String routeName = RoutesName.loginScreen; // Default route
    try {
      await SessionController().getUserFromPreference();
      if (SessionController().isLogin == true) {
        routeName = RoutesName.homeScreen;
      }
    } catch (e) {
      // In case of error, it will default to loginScreen, which is safe.
      print('Error checking login status: $e');
    }

    // Use a single Timer to navigate after the delay
    Timer(
      const Duration(seconds: 3),
      () {
        // A more robust check for navigation
        if (Navigator.of(context).mounted) {
          Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
        }
      },
    );
  }
}
