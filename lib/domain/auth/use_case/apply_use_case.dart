import 'package:injectable/injectable.dart';

import '../../../core/utils/datasource_excution/api_result.dart';
import '../entity/apply_request_entity.dart';
import '../repo/auth_repo.dart';

@injectable
class ApplyUseCase {
  final AuthRepo _authRepo;

  ApplyUseCase(this._authRepo);

  Future<Result<void>> call(ApplyRequestEntity request) async {
    return await _authRepo.apply(request);
  }
}
