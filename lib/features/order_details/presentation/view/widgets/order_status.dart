import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tracking_flower_app/core/utils/l10n/locale_keys.g.dart';

import '../../../../../core/assets/app_colors.dart';

class OrderStatus extends StatelessWidget {
  final String status, orderId, createdDate;

  const OrderStatus({
    super.key,
    required this.status,
    required this.orderId,
    required this.createdDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.lightPink,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '${LocaleKeys.Status.tr()}: $status',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.successGreen,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${LocaleKeys.OrderID.tr()}: $orderId',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            createdDate,
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(color: AppColors.gray),
          ),
        ],
      ),
    );
  }
}
