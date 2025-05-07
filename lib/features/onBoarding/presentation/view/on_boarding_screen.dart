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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(AppImages.onBoardingLogo, fit: BoxFit.cover),
              ),
            ),
            Text(
              tr(LocaleKeys.WelcomeToFloweryRiderApp),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: AppColors.black,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 2),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.pink),
              child: Text(
                tr(LocaleKeys.Login),
                style: const TextStyle(color: AppColors.white, fontSize: 15),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                  side: const BorderSide(color: AppColors.black, width: 1.5),
                ),
              ),
              child: Text(
                tr(LocaleKeys.ApplyNow),
                style: const TextStyle(color: AppColors.black, fontSize: 15),
              ),
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.only(bottom: 18.0, left: 10),
              child: Center(
                child: Text(
                  'Version 1.0.0 (2006)',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: AppColors.gray),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
