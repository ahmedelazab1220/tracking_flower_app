import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/utils/datasource_excution/api_constants.dart';
import '../models/order_item_dto.dart';
import '../models/orders_dto.dart';
import '../models/store_dto.dart';
import '../models/user_dto.dart';

part 'orders_retrofit_client.g.dart';

@singleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class OrdersRetrofitClient {
  @factoryMethod
  factory OrdersRetrofitClient(Dio dio) = _OrdersRetrofitClient;

  @GET(ApiConstants.orders)
  Future<OrdersDto> getOrders(String s

  );

  @GET(ApiConstants.orders)
  Future<OrderItemDto> getOrderItem(
    @Query('productId') String productId,
  );

  @GET(ApiConstants.orders)
  Future<StoreDto> getStore(
    @Query('storeId') String storeId,
  );

  @GET(ApiConstants.orders)
  Future<UserDto> getUser(
    @Query('userId') String userId,
  );
}
