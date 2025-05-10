import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/assets/app_images.dart';
import '../../../../core/utils/l10n/locale_keys.g.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.center,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 4,
                  child: Image.asset(
                    AppImages.successScreen,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  tr(LocaleKeys.ThankYou),
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text(
                  tr(LocaleKeys.TheOrderDeliveredSuccessfully),
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(tr(LocaleKeys.Done)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
