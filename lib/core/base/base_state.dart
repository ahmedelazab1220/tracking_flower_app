sealed class BaseState {}

final class BaseInitialState extends BaseState {}

final class BaseSuccessState extends BaseState {
  dynamic data;

  BaseSuccessState({this.data});
}

final class BaseLoadingState extends BaseState {}

final class BaseHideLoadingState extends BaseState {}

final class BaseErrorState extends BaseState {
  final String errorMessage;
  final Exception? exception;
  final int? statusCode;

  BaseErrorState({required this.errorMessage, this.exception, this.statusCode});
}
