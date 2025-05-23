import 'package:injectable/injectable.dart';

import '../../api/orders_retrofit_client.dart';
import '../../models/order_dto.dart';
import '../contract/orders_remote_data_source.dart';

@Injectable(as: OrdersRemoteDataSource)
class OrdersRemoteDatasourceImpl implements OrdersRemoteDataSource {
  final OrdersRetrofitClient _ordersRetrofitClient;

  OrdersRemoteDatasourceImpl(this._ordersRetrofitClient);

  @override
  Future<OrderDto> getOrders(String userId) async {
    return await _ordersRetrofitClient.getOrders(userId);
  }
}
