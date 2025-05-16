import '../../models/store_dto.dart';

abstract class StoreRemoteDataSource {
  Future<StoreDto> getStore();
}
