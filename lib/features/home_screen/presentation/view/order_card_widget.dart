import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/assets/app_colors.dart';
import '../../../../core/utils/l10n/locale_keys.g.dart';
import 'address_card_widget.dart';

class OrderDetailsCardWidget extends StatelessWidget {
  final String orderTitle;
  final String distance;
  final String statusIcon;
  final String statusText;
  final Color statusColor;
  final String orderId;
  final String pickupAddress;
  final String userAddress;
  final String storeIcon;
  final String locationIcon;
  final String price;
  final VoidCallback onReject;
  final VoidCallback onAccept;

  const OrderDetailsCardWidget({
    super.key,
    required this.orderTitle,
    required this.distance,
    required this.statusIcon,
    required this.statusText,
    required this.statusColor,
    required this.orderId,
    required this.pickupAddress,
    required this.userAddress,
    required this.storeIcon,
    required this.locationIcon,
    required this.price,
    required this.onReject,
    required this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: Colors.grey.withValues(alpha: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(orderTitle, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 10),
            Text(
              distance,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
            Row(
              children: [
                SvgPicture.asset(statusIcon),
                const SizedBox(width: 10),
                Text(
                  statusText,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: statusColor),
                ),
                const Spacer(),
                Text(orderId, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            Text(
              tr(LocaleKeys.PickupAddress),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            OrderCardWidget(
              storeName: pickupAddress,
              pickupAddress: pickupAddress,
              storeIcon: storeIcon,
              locationIcon: locationIcon,
            ),
            Text(
              tr(LocaleKeys.UserAddress),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            OrderCardWidget(
              storeName: userAddress,
              pickupAddress: userAddress,
              storeIcon: storeIcon,
              locationIcon: locationIcon,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(price),
                OutlinedButton(
                  onPressed: onReject,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: AppColors.pink, width: 2),
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                  ),
                  child: Text(
                    tr(LocaleKeys.Reject),
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: AppColors.pink),
                  ),
                ),
                ElevatedButton(
                  onPressed: onAccept,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                  ),
                  child: Text(
                    tr(LocaleKeys.Accept),
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: AppColors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
