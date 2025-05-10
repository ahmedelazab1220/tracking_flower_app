import 'package:flutter/material.dart';
import 'package:tracking_flower_app/features/onBoarding/presentation/view/on_boarding_screen.dart';

import '../../../features/forget_password/presentation/view/email_verification_screen.dart';
import '../../../features/forget_password/presentation/view/forget_password_screen.dart';
import '../../../features/forget_password/presentation/view/reset_password_screen.dart';
import '../../../features/login/presentation/view/screens/login_screen.dart';
import '../../../features/success_screen/presentation/view/success_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String applyRoute = "/apply";
  static const String forgetPasswordRoute = "/forgetPassword";
  static const String resetPasswordRoute = '/reset-password';
  static const String emailVerificationRoute = '/email-verification';
  static const String successRoute = '/success';
  static Map<String, Widget Function(BuildContext)> routes = {
    onBoardingRoute: (context) => const OnBoardingScreen(),
    successRoute: (context) => const SuccessScreen(),
    loginRoute: (context) => const LoginScreen(),
    forgetPasswordRoute: (context) => const ForgetPasswordScreen(),
    resetPasswordRoute: (context) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      final email = args['email'];
      return ResetPasswordScreen(email: email);
    },
    emailVerificationRoute: (context) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      final email = args['email'];
      return EmailVerificationScreen(email: email);
    },
  };
}
