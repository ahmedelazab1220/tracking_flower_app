import 'package:json_annotation/json_annotation.dart';

import 'main_order_dto.dart';
import 'metadata_dto.dart';

part 'orders_dto.g.dart';

@JsonSerializable()
class OrdersDto {
  @JsonKey(name: "message")
  final String? message;
  final MetadataDto? metadata;
  final List<MainOrderDto>? orders;

  OrdersDto({this.message, this.metadata, this.orders});

  factory OrdersDto.fromJson(Map<String, dynamic> json) =>
      _$OrdersDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersDtoToJson(this);
}
