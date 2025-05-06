import 'package:flutter/material.dart';

import '../../../features/apply/presentation/view/approved_apply_screen.dart';

class AppRoutes {
  AppRoutes._();
  static const String loginRoute = "/login";
  static const String applyRoute = "/apply";
  static const String forgetPasswordRoute = "/forgetPassword";
  static const String approvedApplyRoute = "/approvedApply";
  static Map<String, Widget Function(BuildContext)> routes = {
    approvedApplyRoute: (context) => const ApprovedApplyScreen(),
  };
}
