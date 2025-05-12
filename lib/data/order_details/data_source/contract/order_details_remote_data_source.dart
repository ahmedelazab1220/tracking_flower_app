abstract class OrderDetailsRemoteDataSource {
  Future<void> updateOrderState(String orderId, int state);
}
