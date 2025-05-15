import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracking_flower_app/core/assets/app_colors.dart';
import 'package:tracking_flower_app/core/assets/app_images.dart';
import 'package:tracking_flower_app/core/utils/l10n/locale_keys.g.dart';
import 'package:tracking_flower_app/features/onBoarding/presentation/view/on_boarding_screen.dart';

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
  Future<void> pumpOnBoardingScreen(
    WidgetTester tester, {
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
        child: MaterialApp(home: const OnBoardingScreen(), locale: locale),
      ),
    );
    await tester.pumpAndSettle();
  }

  // Test cases
  group('OnBoardingScreen UI Tests', () {
    testWidgets('should display all main components', (
      WidgetTester tester,
    ) async {
      await pumpOnBoardingScreen(tester);

      // Verify the logo image is displayed
      expect(find.byType(Image), findsOneWidget);
      final imageWidget = tester.widget<Image>(find.byType(Image));
      expect(imageWidget.image, isA<AssetImage>());
      expect(
        (imageWidget.image as AssetImage).assetName,
        AppImages.onBoardingLogo,
      );

      // Verify text elements using locale keys
      final textKeys = [
        LocaleKeys.WelcomeToFloweryRiderApp,
        LocaleKeys.Login,
        LocaleKeys.ApplyNow,
        LocaleKeys.Version,
      ];

      for (final key in textKeys) {
        expect(find.text(key.tr()), findsOneWidget);
      }
    });

    testWidgets('should have proper styling for elements', (
      WidgetTester tester,
    ) async {
      await pumpOnBoardingScreen(tester);

      // Verify welcome text style
      final welcomeText = tester.widget<Text>(
        find.text(LocaleKeys.WelcomeToFloweryRiderApp.tr()),
      );
      expect(welcomeText.style?.fontWeight, FontWeight.w500);
      expect(welcomeText.textAlign, TextAlign.start);

      // Verify button styles
      final buttons =
          tester
              .widgetList<ElevatedButton>(find.byType(ElevatedButton))
              .toList();
      expect(buttons.length, 2);

      // Login button (primary)
      expect(
        buttons[0].style?.backgroundColor?.resolve({}),
        isNot(AppColors.white),
      );

      // Apply Now button (secondary)
      expect(buttons[1].style?.backgroundColor?.resolve({}), AppColors.white);
      expect(buttons[1].style?.side?.resolve({})?.color, AppColors.gray);
      expect(buttons[1].style?.side?.resolve({})?.width, greaterThan(1.0));

      // Verify version text is small
      final versionText = tester.widget<Text>(
        find.text(LocaleKeys.Version.tr()),
      );
      expect(versionText.style?.fontWeight, FontWeight.w400);
    });

    testWidgets('should have proper layout structure', (
      WidgetTester tester,
    ) async {
      await pumpOnBoardingScreen(tester);

      // Find the Scaffold
      final scaffoldFinder = find.byType(Scaffold);
      expect(scaffoldFinder, findsOneWidget);

      // Extract the Scaffold widget
      final scaffoldWidget = tester.widget<Scaffold>(scaffoldFinder);

      // The body of Scaffold is the Padding widget
      final paddingWidget = scaffoldWidget.body as Padding;
      expect(
        paddingWidget.padding,
        const EdgeInsets.all(ConstantsFactory.defaultPadding),
      );

      // Verify image takes more space (flex 4)
      final expandedWidgets = tester.widgetList<Expanded>(
        find.byType(Expanded),
      );
      expect(expandedWidgets.length, greaterThanOrEqualTo(1));
      expect(expandedWidgets.first.flex, ConstantsFactory.onBoardingImageFlex);

      // Verify spacing
      final sizedBoxes =
          tester.widgetList<SizedBox>(find.byType(SizedBox)).toList();
      expect(sizedBoxes.length, ConstantsFactory.onBoardingSpacingWidgetCount);
    });

    testWidgets('should display correct localized text for different locales', (
      WidgetTester tester,
    ) async {
      // Test with English
      await pumpOnBoardingScreen(
        tester,
        locale: const Locale(ConstantsFactory.en),
      );
      expect(
        find.text(LocaleKeys.WelcomeToFloweryRiderApp.tr()),
        findsOneWidget,
      );

      // Test with Arabic
      await pumpOnBoardingScreen(
        tester,
        locale: const Locale(ConstantsFactory.ar),
      );
      expect(
        find.text(LocaleKeys.WelcomeToFloweryRiderApp.tr()),
        findsOneWidget,
      );
    });

    testWidgets('should have image with proper fit and coverage', (
      WidgetTester tester,
    ) async {
      await pumpOnBoardingScreen(tester);
      final image = tester.widget<Image>(find.byType(Image));
      expect(image.fit, BoxFit.cover);
    });
  });
}
