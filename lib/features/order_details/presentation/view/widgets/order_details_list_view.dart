import 'package:flutter/material.dart';
import 'package:tracking_flower_app/features/order_details/presentation/view/widgets/order_item.dart';

class OrderDetailsListView extends StatelessWidget {
  const OrderDetailsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Order Details",
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontSize: 18),
        ),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder:
              (context, index) => const OrderItem(
                productImage: "productImage",
                productName: "productName",
                productPrice: "price",
              ),
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemCount: 2,
        ),
      ],
    );
  }
}
