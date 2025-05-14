import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tracking_flower_app/core/assets/app_colors.dart';

import '../../../../core/assets/app_images.dart';
import '../../../../core/utils/l10n/locale_keys.g.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                AppImages.successLogo,
                fit: BoxFit.contain,
                height: 150,
                width: 150,
              ),
              const SizedBox(height: 24),
              Text(
                tr(LocaleKeys.ThankYou),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.green,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                tr(LocaleKeys.TheOrderDeliveredSuccessfully),
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {},
                child: Text(tr(LocaleKeys.Done)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
