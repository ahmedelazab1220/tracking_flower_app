import 'package:injectable/injectable.dart';

import '../../api/auth_retrofit_client.dart';
import '../../models/login_request_dto.dart';
import '../../models/login_response_dto.dart';
import '../../api/auth_retrofit_client.dart';
import '../../models/forget_password_request_dto.dart';
import '../../models/forget_password_response_dto.dart';
import '../../models/reset_password_request_dto.dart';
import '../../models/reset_password_response_dto.dart';
import '../../models/verify_reset_code_request_dto.dart';
import '../../models/verify_reset_code_response_dto.dart';
import '../contract/auth_remote_data_source.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthRetrofitClient _authRetrofitClient;

  AuthRemoteDataSourceImpl(this._authRetrofitClient);

  @override
  Future<LoginResponseDto> login(LoginRequestDto request) async {
    return await _authRetrofitClient.login(request);
  }

  @override
  Future<ForgetPasswordResponseDto> forgetPassword(
      ForgetPasswordRequestDto forgetPasswordRequestDto,
      ) async {
    return await _authRetrofitClient.forgetPassword(forgetPasswordRequestDto);
  }

  @override
  Future<ResetPasswordResponseDto> resetPassword(
      ResetPasswordRequestDto resetPasswordRequestDto,
      ) async {
    return await _authRetrofitClient.resetPassword(resetPasswordRequestDto);
  }

  @override
  Future<VerifyResetCodeResponseDto> verifyResetCode(
      VerifyResetCodeRequestDto verifyResetCodeRequestDto,
      ) async {
    return await _authRetrofitClient.verifyResetCode(verifyResetCodeRequestDto);
  }

}
