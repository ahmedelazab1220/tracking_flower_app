import 'package:injectable/injectable.dart';

import '../../../core/utils/datasource_excution/api_result.dart';
import '../../../data/auth/models/verify_reset_code_request_dto.dart';
import '../repo/auth_repo.dart';

@injectable
class VerifyResetCodeUseCase {
  final AuthRepo _authRepo;

  VerifyResetCodeUseCase(this._authRepo);

  Future<Result<void>> call(
    VerifyResetCodeRequestDto verifyResetCodeRequest,
  ) async {
    return await _authRepo.verifyResetCode(verifyResetCodeRequest);
  }
}
