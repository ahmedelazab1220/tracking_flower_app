import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/utils/datasource_excution/api_constants.dart';
import '../models/login_request_dto.dart';
import '../models/login_response_dto.dart';
import '../models/forget_password_request_dto.dart';
import '../models/forget_password_response_dto.dart';
import '../models/reset_password_request_dto.dart';
import '../models/reset_password_response_dto.dart';
import '../models/verify_reset_code_request_dto.dart';
import '../models/verify_reset_code_response_dto.dart';

part 'auth_retrofit_client.g.dart';

@injectable
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class AuthRetrofitClient {
  @factoryMethod
  factory AuthRetrofitClient(Dio dio) = _AuthRetrofitClient;

  @POST(ApiConstants.login)
  Future<LoginResponseDto> login(@Body() LoginRequestDto request);

  @POST(ApiConstants.forgetPassword)
  Future<ForgetPasswordResponseDto> forgetPassword(
    @Body() ForgetPasswordRequestDto request,
  );

  @POST(ApiConstants.verifyResetCode)
  Future<VerifyResetCodeResponseDto> verifyResetCode(
    @Body() VerifyResetCodeRequestDto request,
  );

  @PUT(ApiConstants.resetPassword)
  Future<ResetPasswordResponseDto> resetPassword(
    @Body() ResetPasswordRequestDto request,
  );
}
