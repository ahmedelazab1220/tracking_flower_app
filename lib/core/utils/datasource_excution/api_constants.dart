class ApiConstants {
  // Private constructor to prevent instantiation
  ApiConstants._();

  static const String baseUrl = "https://flower.elevateegy.com/api/v1/";
  //////////////////////////// Auth Routes ////////////////////////////
  static const String login = "drivers/signin";
  static const String forgetPassword = "drivers/forgotPassword";
  static const String verifyResetCode = "drivers/verifyResetCode";
  static const String resetPassword = "drivers/resetPassword";
  static const String apply = "drivers/apply";
  /////////////////////////// Vehicles Routes //////////////////////////
  static const String vehicles = "vehicles";
}
