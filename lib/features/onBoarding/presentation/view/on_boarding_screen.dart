import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/assets/app_colors.dart';
import '../../../../core/assets/app_images.dart';
import '../../../../core/utils/l10n/locale_keys.g.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0.w),
                child: Image.asset(AppImages.onBoardingLogo, fit: BoxFit.cover),
              ),
            ),
            Text(
              tr(LocaleKeys.WelcomeToFloweryRiderApp),
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 4.h),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.pink),
              child: Text(
                tr(LocaleKeys.Login),
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(color: AppColors.white),
              ),
            ),
            SizedBox(height: 3.h),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.r),
                  side: BorderSide(color: AppColors.black, width: 1.5.w),
                ),
              ),
              child: Text(
                tr(LocaleKeys.ApplyNow),
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 18.0.w),
              child: Center(
                child: Text(
                  'state.version',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
