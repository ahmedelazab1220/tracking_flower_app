import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';

import '../../../core/utils/datasource_excution/api_constants.dart';
import '../models/apply_request_dto.dart';
import '../models/apply_response_dto.dart';
import 'apply_api_manager.dart';

@Injectable(as: ApplyApiManager)
class ApplyApiManagerImpl implements ApplyApiManager {
  final Dio _dio;

  ApplyApiManagerImpl(this._dio);

  @override
  Future<ApplyResponseDto> apply(ApplyRequestDto applyRequestDto) async {
    final formData = FormData.fromMap({
      'country': applyRequestDto.country,
      'firstName': applyRequestDto.firstName,
      'lastName': applyRequestDto.lastName,
      'vehicleType': applyRequestDto.vehicleType,
      'vehicleNumber': applyRequestDto.vehicleNumber,
      'vehicleLicense': await MultipartFile.fromFile(
        applyRequestDto.vehicleLicense.path,
        filename: applyRequestDto.vehicleLicense.path.split('.').last,
        contentType: MediaType("image", 'png'),
      ),
      'NID': applyRequestDto.nid,
      'NIDImg': await MultipartFile.fromFile(
        applyRequestDto.nidImg.path,
        filename: applyRequestDto.nidImg.path.split('.').last,
        contentType: MediaType("image", 'png'),
      ),
      'email': applyRequestDto.email,
      'password': applyRequestDto.password,
      'rePassword': applyRequestDto.rePassword,
      'gender': applyRequestDto.gender,
      'phone': applyRequestDto.phone,
    });

    final response = await _dio.post(
      ApiConstants.baseUrl + ApiConstants.apply,
      data: formData,
    );

    return ApplyResponseDto.fromJson(response.data);
  }
}
