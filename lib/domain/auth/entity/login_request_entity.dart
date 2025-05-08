class LoginRequestEntity {
  final String email;
  final String password;
  final bool isRememberMe;

  LoginRequestEntity({
    required this.email,
    required this.password,
    required this.isRememberMe,
  });
}
