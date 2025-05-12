import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/base/base_state.dart';
import '../../../../../core/utils/datasource_excution/api_result.dart';
import '../../../../../core/utils/validator/validator.dart';
import '../../../../../data/auth/models/forget_password_request_dto.dart';
import '../../../../../domain/auth/use_case/forget_password_use_case.dart';
import 'forget_password_state.dart';

@injectable
class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  final Validator validator;

  ForgetPasswordCubit(this._forgetPasswordUseCase, this.validator)
    : super(ForgetPasswordState(baseState: BaseInitialState()));

  void doIntent(ForgetPasswordAction action) {
    switch (action) {
      case ForgetPasswordRequestAction():
        {
          _forgetPassword();
        }
      case ForgetPasswordAction():
        {
          _validate();
        }
    }
  }

  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ValueNotifier<bool> valid = ValueNotifier(false);

  void _validate() {
    if (formKey.currentState!.validate() && emailController.text.isNotEmpty) {
      valid.value = true;
    } else {
      valid.value = false;
    }
  }

  Future<void> _forgetPassword() async {
    emit(state.copyWith(baseState: BaseLoadingState()));
    final result = await _forgetPasswordUseCase(
      ForgetPasswordRequestDto(email: emailController.text),
    );
    switch (result) {
      case SuccessResult<void>():
        emit(state.copyWith(baseState: BaseSuccessState()));
      case FailureResult<void>():
        emit(
          state.copyWith(
            baseState: BaseErrorState(
              errorMessage: result.exception.toString(),
            ),
          ),
        );
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    valid.dispose();
    return super.close();
  }
}
