import '../../models/orders_dto.dart';

abstract class OrdersRemoteDataSource {
  Future<OrdersDto> getOrders();
}
