import '../../../core/utils/datasource_excution/api_manager.dart';
import '../../../core/utils/datasource_excution/api_result.dart';
import '../../../domain/order/entity/orders_entity.dart';
import '../../../domain/order/repo/orders_repo.dart';
import '../data_source/contract/orders_remote_data_source.dart';

class OrdersRepositoryImpl implements OrdersRepo {
  final ApiManager _apiManager;
  final OrdersRemoteDataSource _ordersRemoteDataSource;

  OrdersRepositoryImpl(this._ordersRemoteDataSource, this._apiManager);

  @override
  Future<Result<OrdersEntity>> getOrders() async {
    return await _apiManager.execute(() async {
      final response = await _ordersRemoteDataSource.getOrders();
      return response.toEntity();
    });
  }
}
