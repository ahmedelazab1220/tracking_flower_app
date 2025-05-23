import '../../../core/utils/datasource_excution/api_result.dart';
import '../entity/store_entity.dart';

abstract class StoreRepo {
  Future<Result<StoreEntity>> getStore(String storeId);
}
