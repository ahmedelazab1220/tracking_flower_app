import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/assets/app_colors.dart';
import '../../../../core/assets/app_images.dart';
import '../../../../core/utils/l10n/locale_keys.g.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 4,
              child: Image.asset(AppImages.onBoardingLogo, fit: BoxFit.cover),
            ),
            Text(
              tr(LocaleKeys.WelcomeToFloweryRiderApp),
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: () {}, child: Text(tr(LocaleKeys.Login))),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.white,
                side: const BorderSide(color: AppColors.gray, width: 1.2),
              ),
              child: Text(
                tr(LocaleKeys.ApplyNow),
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            const Spacer(),
            Center(
              child: Text(
                LocaleKeys.Version.tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
