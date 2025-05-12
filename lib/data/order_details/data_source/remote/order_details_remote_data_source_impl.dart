import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_flower_app/data/order_details/data_source/contract/order_details_remote_data_source.dart';

@Injectable(as: OrderDetailsRemoteDataSource)
class OrderDetailsRemoteDataSourceImpl implements OrderDetailsRemoteDataSource {
  final FirebaseFirestore _firebaseFirestore;

  OrderDetailsRemoteDataSourceImpl(this._firebaseFirestore);

  @override
  Future<void> updateOrderState(String orderId, int status) async {
    await _firebaseFirestore.collection('orders').doc(orderId).update({
      'state': status,
    });
  }
}
