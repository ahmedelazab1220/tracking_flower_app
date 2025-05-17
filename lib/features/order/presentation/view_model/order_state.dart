import 'package:equatable/equatable.dart';

import '../../../../core/base/base_state.dart';

class OrdersState extends Equatable {
  final BaseState? baseState;
  final BaseState? guestState;
  const OrdersState({this.baseState, this.guestState});
  @override
  List<Object?> get props => [baseState, guestState];
  OrdersState copyWith({BaseState? baseState, BaseState? guestState}) {
    return OrdersState(
      baseState: baseState ?? this.baseState,
      guestState: guestState ?? this.guestState,
    );
  }
}

sealed class OrdersAction {}

final class GetUserAction extends OrdersAction {
  final String userId;
  GetUserAction(this.userId);
}
final class GetStoreAction extends OrdersAction {
  final String storeId;
  GetStoreAction(this.storeId);
}
final class GetOrderItemAction extends OrdersAction {
  final String productId;
  GetOrderItemAction(this.productId);
}
final class GetOrdersAction extends OrdersAction {
  final String userId;
  GetOrdersAction(this.userId);
}
