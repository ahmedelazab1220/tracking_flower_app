import '../models/apply_request_dto.dart';
import '../models/apply_response_dto.dart';

abstract class ApplyApiManager {
  Future<ApplyResponseDto> apply(ApplyRequestDto applyRequestDto);
}
