import 'package:injectable/injectable.dart';

import '../../api/orders_retrofit_client.dart';
import '../../models/orders_dto.dart';
import '../contract/orders_remote_data_source.dart';

@Injectable(as: OrdersRemoteDataSource)
class OrdersRemoteDatasourceImpl implements OrdersRemoteDataSource {
  final OrdersRetrofitClient _ordersRetrofitClient;

  OrdersRemoteDatasourceImpl(this._ordersRetrofitClient);

  @override
  Future<OrdersDto> getOrders() async {
    return await _ordersRetrofitClient.getOrders(
      'userId',
    );
  }
}
