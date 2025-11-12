import 'package:first_flutter_v1/core/config/routes_name.dart';
import 'package:first_flutter_v1/features/auth/presentation/view/login_screen.dart';
import 'package:first_flutter_v1/features/message/presentation/view/home_screen.dart';
import 'package:first_flutter_v1/features/splash/presentation/view/splash_screen.dart';

import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case RoutesName.loginScreen:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      default:
        return MaterialPageRoute(
          builder: (context) {
            return const Scaffold(
              body: Center(child: Text("No route generated")),
            );
          },
        );
    }
  }
}
