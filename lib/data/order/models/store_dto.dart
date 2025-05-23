import 'package:json_annotation/json_annotation.dart';
import 'package:tracking_flower_app/domain/order/entity/store_entity.dart';

part 'store_dto.g.dart';

@JsonSerializable()
class StoreDto {
  final String? id;
  final String? name;
  final String? image;
  final String? address;
  final String? phoneNumber;
  final String? latLong;

  StoreDto({
    this.id,
    this.name,
    this.image,
    this.address,
    this.phoneNumber,
    this.latLong,
  });

  factory StoreDto.fromJson(Map<String, dynamic> json) =>
      _$StoreDtoFromJson(json);

  Map<String, dynamic> toJson() => _$StoreDtoToJson(this);

  StoreEntity toEntity() {
    return StoreEntity(
      name: name ?? "",
      image: image ?? "",
      address: address ?? "",
      latLong: latLong ?? "",
      id: id ?? '',
    );
  }
}
