import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/order/repo/order_item_repo.dart';
import '../../../../../domain/order/repo/orders_repo.dart';
import '../../../../../domain/order/repo/store_repo.dart';
import '../../../../../domain/order/repo/user_repo.dart';
import '../../../../../domain/order/usecase/get_order_item_usecase.dart';
import '../../../../../domain/order/usecase/get_orders_usecase.dart';
import '../../../../../domain/order/usecase/get_store_usecase.dart';
import '../../../../../domain/order/usecase/get_user_usecase.dart';
import '../../view_model/order_cubit.dart';
import '../../view_model/order_state.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final cubit = context.read<OrdersCubit>();
        cubit.doIntent(GetOrdersAction(""));
        cubit.doIntent(GetUserAction(""));
        cubit.doIntent(GetStoreAction(""));
        cubit.doIntent(GetOrderItemAction(""));
      },
      child: const Text("Fetch All Data"),
    );
  }
}

void main() {
  runApp(
    BlocProvider(
      create:
          (context) => OrdersCubit(
            GetOrdersUsecase(context.read<OrdersRepo>()),
            GetOrderItemUsecase(context.read<OrderItemRepo>()),
            GetUserUsecase(context.read<UserRepo>()),
            GetStoreUsecase(context.read<StoreRepo>()),
          ),
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: const Text('Order Screen')),
          body: const Center(child: MyWidget()),
        ),
      ),
    ),
  );
}
