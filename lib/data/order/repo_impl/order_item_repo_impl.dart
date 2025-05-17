import '../../../core/utils/datasource_excution/api_manager.dart';
import '../../../core/utils/datasource_excution/api_result.dart';
import '../../../domain/order/entity/order_item_entity.dart';
import '../../../domain/order/repo/order_item_repo.dart';
import '../data_source/contract/order_item_remote_data_source.dart';

class OrderItemRepositoryImpl implements OrderItemRepo {
  final ApiManager _apiManager;
  final OrderItemRemoteDataSource _orderItemRemoteDataSource;

  OrderItemRepositoryImpl(this._orderItemRemoteDataSource, this._apiManager);
  @override
  Future<Result<OrderItemEntity>> getOrderItem() async {
    return await _apiManager.execute(() async {
      final response = await _orderItemRemoteDataSource.getOrderItem();
      return response.toEntity();
    });
  }
}
