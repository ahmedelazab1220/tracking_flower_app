import 'package:flutter/material.dart';
import 'package:tracking_flower_app/features/onBoarding/presentation/view/on_boarding_screen.dart';

import '../../../features/login/presentation/view/screens/login_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String applyRoute = "/apply";
  static const String forgetPasswordRoute = "/forgetPassword";
  static Map<String, Widget Function(BuildContext)> routes = {
    onBoardingRoute: (context) => const OnBoardingScreen(),
    loginRoute: (context) => const LoginScreen(),
  };
}
