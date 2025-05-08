import 'package:tracking_flower_app/domain/auth/entity/login_request_entity.dart';

import '../../../core/utils/datasource_excution/api_result.dart';

abstract class AuthRepo {
  Future<Result<void>> login(LoginRequestEntity request);
}
