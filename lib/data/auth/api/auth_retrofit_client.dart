import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/utils/datasource_excution/api_constants.dart';
import '../models/login_request_dto.dart';
import '../models/login_response_dto.dart';

part 'auth_retrofit_client.g.dart';

@injectable
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class AuthRetrofitClient {
  @factoryMethod
  factory AuthRetrofitClient(Dio dio) = _AuthRetrofitClient;

  @POST(ApiConstants.login)
  Future<LoginResponseDto> login(@Body() LoginRequestDto request);
}
