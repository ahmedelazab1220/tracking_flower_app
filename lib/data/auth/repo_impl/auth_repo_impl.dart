import 'package:injectable/injectable.dart';

import '../../../core/utils/datasource_excution/api_manager.dart';
import '../../../core/utils/datasource_excution/api_result.dart';
import '../../../domain/auth/repo/auth_repo.dart';
import '../data_source/contract/auth_remote_data_source.dart';
import '../models/forget_password_request_dto.dart';
import '../models/reset_password_request_dto.dart';
import '../models/verify_reset_code_request_dto.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final ApiManager _apiManager;
  final AuthRemoteDataSource _authRemoteDataSource;
  AuthRepoImpl(this._apiManager, this._authRemoteDataSource);
  @override
  Future<Result<void>> forgetPassword(
    ForgetPasswordRequestDto forgetPasswordRequestDto,
  ) async {
    return await _apiManager.execute(() async {
      await _authRemoteDataSource.forgetPassword(forgetPasswordRequestDto);
    });
  }

  @override
  Future<Result<void>> resetPassword(
    ResetPasswordRequestDto resetPasswordRequestDto,
  ) async {
    return await _apiManager.execute(() async {
      await _authRemoteDataSource.resetPassword(resetPasswordRequestDto);
    });
  }

  @override
  Future<Result<void>> verifyResetCode(
    VerifyResetCodeRequestDto verifyResetCodeRequestDto,
  ) async {
    return await _apiManager.execute(() async {
      await _authRemoteDataSource.verifyResetCode(verifyResetCodeRequestDto);
    });
  }
}
