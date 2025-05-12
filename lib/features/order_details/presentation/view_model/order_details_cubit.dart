import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_flower_app/core/base/base_state.dart';

import '../../../../core/utils/datasource_excution/api_result.dart';
import '../../../../domain/order_details/use_case/update_order_state_use_case.dart';
import 'order_details_state.dart';

@injectable
class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  final UpdateOrderStateUseCase _updateOrderStateUseCase;

  OrderDetailsCubit(this._updateOrderStateUseCase)
    : super(OrderDetailsState(orderState: BaseInitialState()));

  void doIntent(OrderDetailsAction action) {
    switch (action) {
      case UpdateOrderStateAction():
        _updateOrderState(action.orderId, action.status);
    }
  }

  Future<void> _updateOrderState(String orderId, int status) async {
    emit(state.copyWith(orderState: BaseLoadingState()));
    final result = await _updateOrderStateUseCase.call(orderId, status);
    switch (result) {
      case SuccessResult<void>():
        emit(state.copyWith(orderState: BaseSuccessState()));
      case FailureResult<void>():
        emit(
          state.copyWith(
            orderState: BaseErrorState(
              errorMessage: result.exception.toString(),
            ),
          ),
        );
    }
  }
}
