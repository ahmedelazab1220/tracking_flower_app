import 'package:flutter/material.dart';

class AppRoutes {
  AppRoutes._();
  static const String loginRoute = "/login";
  static const String applyRoute = "/apply";
  static const String forgetPasswordRoute = "/forgetPassword";
  static Map<String, Widget Function(BuildContext)> routes = {};
}
