import 'package:equatable/equatable.dart';
import 'package:tracking_flower_app/core/base/base_state.dart';

class OrderDetailsState extends Equatable {
  final BaseState? orderState;

  const OrderDetailsState({this.orderState});

  OrderDetailsState copyWith({BaseState? orderState}) {
    return OrderDetailsState(orderState: orderState ?? this.orderState);
  }

  @override
  List<Object?> get props => [orderState];
}

sealed class OrderDetailsAction {}

class UpdateOrderStateAction extends OrderDetailsAction {
  final String orderId;
  final int status;

  UpdateOrderStateAction(this.orderId, this.status);
}
