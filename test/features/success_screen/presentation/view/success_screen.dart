import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracking_flower_app/core/assets/app_colors.dart';
import 'package:tracking_flower_app/core/assets/app_images.dart';
import 'package:tracking_flower_app/core/utils/l10n/locale_keys.g.dart';
import 'package:tracking_flower_app/features/success_screen/presentation/view/success_screen.dart';

import '../../../../constants_factory.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Setup EasyLocalization before tests
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
    EasyLocalization.logger.enableLevels = [];
    EasyLocalization.logger.enableBuildModes = [];
  });

  // Helper function to build the test widget
  Future<void> pumpSuccessScreen(WidgetTester tester, {
    Locale? locale,
  }) async {
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [
          Locale(ConstantsFactory.en),
          Locale(ConstantsFactory.ar),
        ],
        path: ConstantsFactory.assetsTranslations,
        fallbackLocale: const Locale(ConstantsFactory.en),
        child: MaterialApp(home: const SuccessScreen(), locale: locale),
      ),
    );
    await tester.pumpAndSettle();
  }

  // Test cases
  group('SuccessScreen UI Tests', () {
    testWidgets('should display all main components', (
      WidgetTester tester,
    ) async {
      await pumpSuccessScreen(tester);

      // Verify the success logo image is displayed
      expect(find.byType(Image), findsOneWidget);
      final imageWidget = tester.widget<Image>(find.byType(Image));
      expect(imageWidget.image, isA<AssetImage>());
      expect(
        (imageWidget.image as AssetImage).assetName,
        AppImages.successLogo,
      );

      // Verify text elements using locale keys
      final textKeys = [
        LocaleKeys.ThankYou,
        LocaleKeys.TheOrderDeliveredSuccessfully,
        LocaleKeys.Done,
      ];

      for (final key in textKeys) {
        expect(find.text(key.tr()), findsOneWidget);
      }
    });

    testWidgets('should have proper styling for elements', (
      WidgetTester tester,
    ) async {
      await pumpSuccessScreen(tester);

      // Verify Thank You text style
      final thankYouText = tester.widget<Text>(
        find.text(LocaleKeys.ThankYou.tr()),
      );
      expect(thankYouText.style?.fontWeight, FontWeight.w500);
      expect(thankYouText.style?.color, AppColors.green);
      expect(thankYouText.textAlign, TextAlign.center);

      // Verify button styles
      final button = 
      tester
      .widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(
        button.style?.backgroundColor?.resolve({}),
        isNot(AppColors.white),
      );
    });

    testWidgets('should have proper layout structure', (
      WidgetTester tester,
    ) async {
      await pumpSuccessScreen(tester);

      // Verify presence of Scaffold
      expect(find.byType(Scaffold), findsOneWidget);

      // Verify padding for main content
      final paddingWidget = tester.widget<Padding>(find.byType(Padding));
      expect(paddingWidget.padding, const EdgeInsets.all(16.0));

      // Verify spacing
      final sizedBoxes =
          tester.widgetList<SizedBox>(find.byType(SizedBox)).toList();
      expect(sizedBoxes.length, greaterThanOrEqualTo(2));
    });

    testWidgets('should display correct localized text for different locales', (
      WidgetTester tester,
    ) async {
      // Test with English
      await pumpSuccessScreen(
        tester,
        locale: const Locale(ConstantsFactory.en),
      );
      expect(find.text(LocaleKeys.ThankYou.tr()), findsOneWidget);

      // Test with Arabic
      await pumpSuccessScreen(
        tester,
        locale: const Locale(ConstantsFactory.ar),
      );
      expect(find.text(LocaleKeys.ThankYou.tr()), findsOneWidget);
    });

    testWidgets('should have image with proper fit and coverage', (
      WidgetTester tester,
    ) async {
      await pumpSuccessScreen(tester);
      final image = tester.widget<Image>(find.byType(Image));
      expect(image.fit, BoxFit.contain);
    });
  });
}