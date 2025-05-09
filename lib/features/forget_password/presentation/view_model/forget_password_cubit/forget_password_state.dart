import 'package:equatable/equatable.dart';
import '../../../../../core/base/base_state.dart';

class ForgetPasswordState extends Equatable {
  final BaseState? baseState;

  const ForgetPasswordState({this.baseState});

  ForgetPasswordState copyWith({BaseState? baseState}) {
    return ForgetPasswordState(baseState: baseState ?? this.baseState);
  }

  @override
  List<Object?> get props => [baseState];
}

sealed class ForgetPasswordAction {}

final class ForgetPasswordRequestAction extends ForgetPasswordAction {}

final class FormDataChangedAction extends ForgetPasswordAction {}
