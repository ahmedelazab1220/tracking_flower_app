import 'package:json_annotation/json_annotation.dart';

import '../../../domain/auth/entity/vehicles_entity.dart';

part 'vehicles_dto.g.dart';

@JsonSerializable()
class VehiclesDto {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "image")
  final String? image;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "__v")
  final int? v;

  VehiclesDto({
    this.id,
    this.type,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory VehiclesDto.fromJson(Map<String, dynamic> json) =>
      _$VehiclesDtoFromJson(json);

  Map<String, dynamic> toJson() => _$VehiclesDtoToJson(this);

  VehiclesEntity toEntity() => VehiclesEntity(
    id: id,
    type: type,
    image: image,
    createdAt: createdAt,
    updatedAt: updatedAt,
    v: v,
  );
}
