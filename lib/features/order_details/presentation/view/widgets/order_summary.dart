import 'package:flutter/material.dart';
import 'package:tracking_flower_app/core/assets/app_colors.dart';

class OrderSummary extends StatelessWidget {
  final String title;
  final String subtitle;

  const OrderSummary({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: AppColors.lightGray,
            blurRadius: 4,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(title, style: Theme.of(context).textTheme.titleMedium),
          ),
          Text(subtitle, style: Theme.of(context).textTheme.titleSmall),
        ],
      ),
    );
  }
}
