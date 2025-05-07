import 'package:flutter/material.dart';

import '../../../features/forget_password/presentation/view/email_verification_screen.dart';
import '../../../features/forget_password/presentation/view/forget_password_screen.dart';
import '../../../features/forget_password/presentation/view/reset_password_screen.dart';

class AppRoutes {
  AppRoutes._();
  static const String loginRoute = "/login";
  static const String applyRoute = "/apply";
  static const String forgetPasswordRoute = "/forgetPassword";
  static const String resetPasswordRoute = '/reset-password';
  static const String emailVerificationRoute = '/email-verification';
  static Map<String, Widget Function(BuildContext)> routes = {
    forgetPasswordRoute: (context) => const ForgetPasswordScreen(),
    resetPasswordRoute: (context) {
      final email = ModalRoute.of(context)?.settings.arguments as String;
      return ResetPasswordScreen(email: email);
    },
    emailVerificationRoute: (context) {
      final email = ModalRoute.of(context)?.settings.arguments as String;
      return EmailVerificationScreen(email: email);
    },
  };
}
