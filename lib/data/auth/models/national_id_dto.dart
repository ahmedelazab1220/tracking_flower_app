import 'package:json_annotation/json_annotation.dart';

import '../../../domain/auth/entity/national_id_entity.dart';

part 'national_id_dto.g.dart';

@JsonSerializable()
class NationalIdDto {
  final String? idNumber;
  final String? dateOfBirth;
  final String? name;
  final bool isValidNationalId;
  final String? errorMessage;

  NationalIdDto({
    required this.idNumber,
    required this.dateOfBirth,
    required this.name,
    required this.isValidNationalId,
    required this.errorMessage,
  });

  factory NationalIdDto.fromJson(Map<String, dynamic> json) =>
      _$NationalIdDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NationalIdDtoToJson(this);

  NationalIdEntity toEntity() => NationalIdEntity(
    idNumber: idNumber,
    dateOfBirth: dateOfBirth,
    name: name,
    isValidNationalId: isValidNationalId,
    errorMessage: errorMessage,
  );
}
