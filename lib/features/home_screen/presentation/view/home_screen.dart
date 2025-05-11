import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tracking_flower_app/core/assets/app_colors.dart';
import 'package:tracking_flower_app/core/utils/l10n/locale_keys.g.dart';

import '../../../../core/assets/app_icons.dart';
import 'order_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isReadyForDelivery = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(LocaleKeys.FloweryRider)),
        actions: [
          Text(tr(LocaleKeys.ReadyForDelivery)),
          Theme(
            data: ThemeData(
              switchTheme: SwitchThemeData(
                thumbColor: WidgetStateProperty.all(AppColors.gray),
                trackColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return AppColors.pink;
                  }
                  return Colors.white;
                }),
              ),
            ),

            child: Switch(
              value: isReadyForDelivery,
              onChanged: (bool value) {
                setState(() {
                  isReadyForDelivery = value;
                });
              },
              activeColor: Colors.white,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: orders.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final order = orders[index];
          return OrderDetailsCardWidget(
            orderTitle: order['orderTitle'],
            distance: order['distance'],
            statusIcon: order['statusIcon'],
            statusText: order['statusText'],
            statusColor: order['statusColor'],
            orderId: order['orderId'],
            pickupAddress: order['pickupAddress'],
            userAddress: order['userAddress'],
            storeIcon: order['storeIcon'],
            locationIcon: order['locationIcon'],
            price: order['price'],
            onReject: () {
              if (kDebugMode) {
                print("Order ${order['orderId']} Rejected");
              }
            },
            onAccept: () {
              if (kDebugMode) {
                print("Order ${order['orderId']} Accepted");
              }
            },
          );
        },
      ),
    );
  }
}

final List<Map<String, dynamic>> orders = [
  {
    "orderTitle": tr(LocaleKeys.FlowerOrder),
    "distance": "15 km",
    "statusIcon": AppIcons.pendingStatusIcon,
    "statusText": tr(LocaleKeys.Pending),
    "statusColor": AppColors.yellow,
    "orderId": "Order #124",
    "pickupAddress": tr(LocaleKeys.PickupAddress),
    "userAddress": tr(LocaleKeys.UserAddress),
    "storeIcon": AppIcons.floweryStore,
    "locationIcon": AppIcons.locationIcon,
    "price": "EGP 500",
  },
  {
    "orderTitle": tr(LocaleKeys.FlowerOrder),
    "distance": "15 km",
    "statusIcon": AppIcons.pendingStatusIcon,
    "statusText": tr(LocaleKeys.Pending),
    "statusColor": AppColors.yellow,
    "orderId": "Order #124",
    "pickupAddress": tr(LocaleKeys.PickupAddress),
    "userAddress": tr(LocaleKeys.UserAddress),
    "storeIcon": AppIcons.floweryStore,
    "locationIcon": AppIcons.locationIcon,
    "price": "EGP 500",
  },
  {
    "orderTitle": tr(LocaleKeys.FlowerOrder),
    "distance": "15 km",
    "statusIcon": AppIcons.pendingStatusIcon,
    "statusText": tr(LocaleKeys.Pending),
    "statusColor": AppColors.yellow,
    "orderId": "Order #124",
    "pickupAddress": tr(LocaleKeys.PickupAddress),
    "userAddress": tr(LocaleKeys.UserAddress),
    "storeIcon": AppIcons.floweryStore,
    "locationIcon": AppIcons.locationIcon,
    "price": "EGP 500",
  },
  {
    "orderTitle": tr(LocaleKeys.FlowerOrder),
    "distance": "15 km",
    "statusIcon": AppIcons.pendingStatusIcon,
    "statusText": tr(LocaleKeys.Pending),
    "statusColor": AppColors.yellow,
    "orderId": "Order #124",
    "pickupAddress": tr(LocaleKeys.PickupAddress),
    "userAddress": tr(LocaleKeys.UserAddress),
    "storeIcon": AppIcons.floweryStore,
    "locationIcon": AppIcons.locationIcon,
    "price": "EGP 500",
  },
];
