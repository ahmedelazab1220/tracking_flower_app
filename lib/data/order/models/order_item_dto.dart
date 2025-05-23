import 'package:json_annotation/json_annotation.dart';
import 'package:tracking_flower_app/domain/order/entity/order_item_entity.dart';

part 'order_item_dto.g.dart';

@JsonSerializable()
class OrderItemDto {
  final String? id;
  @JsonKey(name: "product")
  final String? product;
  final int? price;
  final int? quantity;

  OrderItemDto({this.id, this.product, this.price, this.quantity});

  factory OrderItemDto.fromJson(Map<String, dynamic> json) =>
      _$OrderItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemDtoToJson(this);

  OrderItemEntity toEntity() {
    return OrderItemEntity(
      product: product ?? "",
      price: price ?? 0,
      quantity: quantity ?? 0,
      id: id ?? '',
    );
  }
}
