import '../../../core/utils/datasource_excution/api_manager.dart';
import '../../../core/utils/datasource_excution/api_result.dart';
import '../../../domain/order/entity/store_entity.dart';
import '../../../domain/order/repo/store_repo.dart';
import '../data_source/contract/store_remote_data_source.dart';

class StoreRepositoryImpl implements StoreRepo {
  final ApiManager _apiManager;
  final StoreRemoteDataSource _storeRemoteDataSource;

  StoreRepositoryImpl(this._storeRemoteDataSource, this._apiManager);

  @override
  Future<Result<StoreEntity>> getStore() async {
    return await _apiManager.execute(() async {
      final response = await _storeRemoteDataSource.getStore();
      return response.toEntity();
    });
  }
}
