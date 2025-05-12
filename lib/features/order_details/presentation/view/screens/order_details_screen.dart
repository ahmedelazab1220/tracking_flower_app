import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tracking_flower_app/core/utils/l10n/locale_keys.g.dart';
import 'package:tracking_flower_app/features/order_details/presentation/view/widgets/order_details_list_view.dart';
import 'package:tracking_flower_app/features/order_details/presentation/view/widgets/order_summary.dart';
import 'package:tracking_flower_app/features/order_details/presentation/view/widgets/order_progress_bar.dart';

import '../widgets/order_address_item.dart';
import '../widgets/order_status.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.OrderDetails.tr())),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const OrderProgressBar(currentStep: 2, totalSteps: 5),
              const SizedBox(height: 24),
              const OrderStatus(status: '1', orderId: '1', createdDate: '1'),
              const SizedBox(height: 16),
              OrderAddressItem(
                title: LocaleKeys.PickupAddress.tr(),
                image: '',
                name: 'John Doe',
                address: '123 Main St, Springfield, USA',
                onCall: () {},
                onWhatsApp: () {},
              ),
              const SizedBox(height: 24),
              OrderAddressItem(
                title: LocaleKeys.UserAddress.tr(),
                image: '',
                name: 'John Doe',
                address: '123 Main St, Springfield, USA',
                onCall: () {},
                onWhatsApp: () {},
              ),
              const SizedBox(height: 24),
              const OrderDetailsListView(),
              OrderSummary(
                title: LocaleKeys.Total.tr(),
                subtitle: "${LocaleKeys.EGP.tr()} 100.00",
              ),
              const SizedBox(height: 16),
              OrderSummary(
                title: LocaleKeys.PayementMethod.tr(),
                subtitle: LocaleKeys.CashOnDelivery.tr(),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                child: Text(LocaleKeys.Confirm.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
