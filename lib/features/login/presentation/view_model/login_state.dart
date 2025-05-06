import 'package:equatable/equatable.dart';

import '../../../../core/base/base_state.dart';

class LoginState extends Equatable {
  final BaseState? loginState;
  final bool? isRememberMe;
  final bool? isValidate;

  const LoginState({this.loginState, this.isRememberMe, this.isValidate});

  LoginState copyWith({
    BaseState? loginState,
    bool? isRememberMe,
    bool? isValidate,
  }) {
    return LoginState(
      loginState: loginState ?? this.loginState,
      isRememberMe: isRememberMe ?? this.isRememberMe,
      isValidate: isValidate ?? this.isValidate,
    );
  }

  @override
  List<Object?> get props => [loginState, isRememberMe, isValidate];
}

sealed class LoginAction {}

final class LoginRequestAction extends LoginAction {}

final class RememberMeAction extends LoginAction {
  final bool isRememberMe;

  RememberMeAction(this.isRememberMe);
}

class ValidateButtonAction extends LoginAction {}
