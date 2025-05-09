import 'package:injectable/injectable.dart';

import '../../../core/utils/datasource_excution/api_result.dart';
import '../../../data/auth/models/reset_password_request_dto.dart';
import '../repo/auth_repo.dart';

@injectable
class ResetPasswordUseCase {
  final AuthRepo _authRepo;

  ResetPasswordUseCase(this._authRepo);

  Future<Result<void>> call(ResetPasswordRequestDto request) async {
    return await _authRepo.resetPassword(request);
  }
}
