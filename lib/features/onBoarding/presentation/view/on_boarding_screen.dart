import 'package:flutter/material.dart';
import 'package:tracking_flower_app/core/assets/app_colors.dart';
import 'package:tracking_flower_app/core/assets/app_images.dart';
import 'package:tracking_flower_app/core/utils/l10n/locale_keys.g.dart';
import 'package:tracking_flower_app/features/onBoarding/presentation/view/custom_button.dart';
import 'package:tracking_flower_app/features/onBoarding/presentation/view/text_field.dart'
    as custom;

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
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              LocaleKeys.WelcomeToFloweryRiderApp,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: AppColors.black,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          CustomButton(
            label: LocaleKeys.Login,
            onPressed: () {},
            color: AppColors.pink,
            textStyle: const TextStyle(color: AppColors.white, fontSize: 18),
          ),
          CustomButton(
            label: LocaleKeys.ApplyNow,
            onPressed: () {},
            color: AppColors.white,
            textStyle: const TextStyle(color: AppColors.black, fontSize: 18),
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
