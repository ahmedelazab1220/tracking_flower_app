import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderCardWidget extends StatelessWidget {
  final String storeName;
  final String pickupAddress;
  final String storeIcon;
  final String locationIcon;

  const OrderCardWidget({
    super.key,
    required this.storeName,
    required this.pickupAddress,
    required this.storeIcon,
    required this.locationIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            SvgPicture.asset(storeIcon, width: 50, height: 50),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  storeName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      locationIcon,
                      color: Colors.black,
                      width: 18,
                      height: 18,
                    ),
                    const SizedBox(width: 5),
                    Text(pickupAddress),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
