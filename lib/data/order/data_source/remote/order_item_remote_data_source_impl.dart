import 'package:injectable/injectable.dart';

import '../../api/orders_retrofit_client.dart';
import '../../models/order_item_dto.dart';
import '../contract/order_item_remote_data_source.dart';

@Injectable(as: OrderItemRemoteDataSource)
class OrderItemRemoteDatasourceImpl implements OrderItemRemoteDataSource {
  final OrdersRetrofitClient _orderItemRetrofitClient;

  OrderItemRemoteDatasourceImpl(this._orderItemRetrofitClient);

  @override
  Future<OrderItemDto> getOrderItem() async {
    return await _orderItemRetrofitClient.getOrderItem();
  }
}
