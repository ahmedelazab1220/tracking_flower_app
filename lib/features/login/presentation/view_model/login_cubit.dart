import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_flower_app/domain/auth/entity/login_request_entity.dart';
import 'package:tracking_flower_app/features/login/presentation/view_model/login_state.dart';

import '../../../../core/base/base_state.dart';
import '../../../../core/utils/datasource_excution/api_result.dart';
import '../../../../core/utils/validator/validator.dart';
import '../../../../domain/auth/usecase/login_usecase.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUsecase _loginUsecase;
  final Validator validator;

  LoginCubit(this._loginUsecase, this.validator)
    : super(
        LoginState(
          loginState: BaseInitialState(),
          isRememberMe: false,
          isValidate: false,
        ),
      );

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isRememberMe = false;
  bool validate = false;

  void doIntent(LoginAction action) {
    switch (action) {
      case LoginRequestAction():
        _login();
      case RememberMeAction():
        _rememberMe(action.isRememberMe);
      case ValidateButtonAction():
        _validateButton();
    }
  }

  Future<void> _login() async {
    emit(state.copyWith(loginState: BaseLoadingState()));
    final result = await _loginUsecase.call(
      LoginRequestEntity(
        email: emailController.text,
        password: passwordController.text,
        isRememberMe: isRememberMe,
      ),
    );
    switch (result) {
      case SuccessResult<void>():
        emit(state.copyWith(loginState: BaseSuccessState()));
      case FailureResult<void>():
        emit(
          state.copyWith(
            loginState: BaseErrorState(
              errorMessage: result.exception.toString(),
            ),
          ),
        );
    }
  }

  void _rememberMe(bool value) {
    isRememberMe = value;
    emit(state.copyWith(isRememberMe: isRememberMe));
  }

  void _validateButton() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      validate = false;
    } else if (!formKey.currentState!.validate()) {
      validate = false;
    } else {
      validate = true;
    }
    emit(state.copyWith(loginState: BaseInitialState(), isValidate: validate));
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.close();
  }
}
