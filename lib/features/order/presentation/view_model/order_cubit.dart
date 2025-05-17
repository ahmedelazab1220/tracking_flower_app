import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/base/base_state.dart';
import '../../../../core/utils/datasource_excution/api_result.dart';
import '../../../../domain/order/entity/order_item_entity.dart';
import '../../../../domain/order/entity/orders_entity.dart';
import '../../../../domain/order/entity/store_entity.dart';
import '../../../../domain/order/entity/user_entity.dart';
import '../../../../domain/order/usecase/get_order_item_usecase.dart';
import '../../../../domain/order/usecase/get_orders_usecase.dart';
import '../../../../domain/order/usecase/get_store_usecase.dart';
import '../../../../domain/order/usecase/get_user_usecase.dart';
import 'order_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final GetOrdersUsecase _getOrdersUsecase;
  final GetOrderItemUsecase _getOrderItemUsecase;
  final GetUserUsecase _getUserUsecase;
  final GetStoreUsecase _getStoreUsecase;

  OrdersCubit(
    this._getOrdersUsecase,
    this._getOrderItemUsecase,
    this._getUserUsecase,
    this._getStoreUsecase,
  ) : super(OrdersState(baseState: BaseInitialState()));

  void doIntent(OrdersAction action) {
    switch (action) {
      case GetOrdersAction():
        _getOrders();
      case GetOrderItemAction():
        _getOrderItem(action.productId);
      case GetUserAction():
        _getUser(action.userId);
      case GetStoreAction():
        _getStore(action.storeId);
    }
  }

  Future<void> _getOrders() async {
    emit(state.copyWith(baseState: BaseLoadingState()));
    final result = await _getOrdersUsecase();
    switch (result) {
      case SuccessResult<OrdersEntity>():
        emit(state.copyWith(baseState: BaseSuccessState(data: result.data)));
      case FailureResult<OrdersEntity>():
        emit(
          state.copyWith(
            baseState: BaseErrorState(
              errorMessage: result.exception.toString(),
            ),
          ),
        );
    }
  }

  Future<void> _getStore(String storeId) async {
    emit(state.copyWith(baseState: BaseLoadingState()));
    final result = await _getStoreUsecase();
    switch (result) {
      case SuccessResult<StoreEntity>():
        emit(state.copyWith(baseState: BaseSuccessState(data: result.data)));
      case FailureResult<StoreEntity>():
        emit(
          state.copyWith(
            baseState: BaseErrorState(
              errorMessage: result.exception.toString(),
            ),
          ),
        );
    }
  }

  Future<void> _getUser(String userId) async {
    emit(state.copyWith(baseState: BaseLoadingState()));
    final result = await _getUserUsecase();
    switch (result) {
      case SuccessResult<UserEntity>():
        emit(state.copyWith(baseState: BaseSuccessState(data: result.data)));
      case FailureResult<UserEntity>():
        emit(
          state.copyWith(
            baseState: BaseErrorState(
              errorMessage: result.exception.toString(),
            ),
          ),
        );
    }
  }

  Future<void> _getOrderItem(String productId) async {
    emit(state.copyWith(baseState: BaseLoadingState()));
    final result = await _getOrderItemUsecase();
    switch (result) {
      case SuccessResult<OrderItemEntity>():
        emit(state.copyWith(baseState: BaseSuccessState(data: result.data)));
      case FailureResult<OrderItemEntity>():
        emit(
          state.copyWith(
            baseState: BaseErrorState(
              errorMessage: result.exception.toString(),
            ),
          ),
        );
    }
  }
}
