import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tracking_flower_app/core/assets/app_colors.dart';

import '../../../../../core/assets/app_icons.dart';

class OrderAddressItem extends StatelessWidget {
  final String title;
  final String image;
  final String name;
  final String address;
  final VoidCallback onCall;
  final VoidCallback onWhatsApp;

  const OrderAddressItem({
    super.key,
    required this.title,
    required this.image,
    required this.name,
    required this.address,
    required this.onCall,
    required this.onWhatsApp,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontSize: 18),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
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
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.pink.shade700,
                backgroundImage: NetworkImage(image),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      name,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(fontSize: 13),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      address,
                      style: Theme.of(
                        context,
                      ).textTheme.labelMedium?.copyWith(fontSize: 13),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: onCall,
                    child: SvgPicture.asset(
                      AppIcons.callIcon,
                      width: 20,
                      height: 20,
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: onWhatsApp,
                    child: SvgPicture.asset(
                      AppIcons.whatsappIcon,
                      width: 20,
                      height: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
