import '../../../core/utils/datasource_excution/api_result.dart';
import '../entity/orders_entity.dart';

abstract class OrdersRepo {
  Future<Result<OrderEntity>> getOrders(String ordersId);
}
