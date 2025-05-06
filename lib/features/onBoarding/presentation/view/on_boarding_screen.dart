import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/assets/app_colors.dart';
import '../../../../core/assets/app_images.dart';
import '../../../../core/utils/l10n/locale_keys.g.dart';
import 'custom_button.dart';
import 'text_field.dart' as custom;

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(AppImages.onBoardingLogo, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              tr(LocaleKeys.WelcomeToFloweryRiderApp),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: AppColors.black,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          CustomButton(
            label: tr(LocaleKeys.Login),
            onPressed: () {},
            color: AppColors.pink,
            textStyle: const TextStyle(color: AppColors.white, fontSize: 15),
          ),
          CustomButton(
            label: tr(LocaleKeys.ApplyNow),
            onPressed: () {},
            color: AppColors.white,
            textStyle: const TextStyle(color: AppColors.black, fontSize: 15),
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.only(bottom: 18.0),
            child: Center(
              child: custom.TextField(
                label: 'Version 1.0.0 (2006)',
                textStyle: TextStyle(fontSize: 12, color: AppColors.gray),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
