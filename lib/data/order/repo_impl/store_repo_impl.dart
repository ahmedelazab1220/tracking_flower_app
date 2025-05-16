import '../models/store_dto.dart';

abstract class StoreRepository {
  Future<StoreDto> getStore();
}
