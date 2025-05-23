import 'package:injectable/injectable.dart';

import '../../../../core/utils/datasource_excution/api_result.dart';
import '../entity/store_entity.dart';
import '../repo/store_repo.dart';

@injectable
class GetStoreUsecase {
  final StoreRepo _storeRepo;

  GetStoreUsecase(this._storeRepo);

  Future<Result<StoreEntity>> call(String storeId) async {
    return await _storeRepo.getStore(storeId);
  }
}
