import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tracking_flower_app/core/assets/app_colors.dart';

import '../../../../core/assets/app_images.dart';
import '../../../../core/utils/l10n/locale_keys.g.dart';

class ApprovedApplyScreen extends StatelessWidget {
  const ApprovedApplyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset(AppImages.backgroundLogo),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Image.asset(AppImages.checkCircle),
                ),
                const SizedBox(height: 24),
                Text(
                  LocaleKeys.YourApplicationHasBeenSubmitted.tr(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  LocaleKeys
                      .ThankYouForProvidingYourApplicationWeWillReviewYourApplicationAndWillGetBackToYouSoon.tr(),
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: AppColors.gray),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(LocaleKeys.Login.tr()),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
