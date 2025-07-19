import 'package:injectable/injectable.dart';

import '../../../core/utils/datasource_excution/api_result.dart';
import '../entity/vehicles_entity.dart';
import '../repo/auth_repo.dart';

@injectable
class GetAllVehiclesUseCase {
  final AuthRepo _authRepo;

  GetAllVehiclesUseCase(this._authRepo);

  Future<Result<List<VehiclesEntity>>> call() async =>
      await _authRepo.getVehicles();
}
