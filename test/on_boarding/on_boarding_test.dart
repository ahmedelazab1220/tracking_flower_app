import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tracking_flower_app/core/utils/l10n/locale_keys.g.dart';
import 'package:tracking_flower_app/features/onBoarding/presentation/view/on_boarding_screen.dart';

void main() {
  testWidgets('OnBoardingScreen UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: OnBoardingScreen()));

    await tester.pumpAndSettle();

    expect(find.byType(Image), findsOneWidget);

    expect(find.text(tr(LocaleKeys.WelcomeToFloweryRiderApp)), findsOneWidget);

    expect(find.text(tr(LocaleKeys.Login)), findsOneWidget);
    expect(find.text(tr(LocaleKeys.ApplyNow)), findsOneWidget);

    await tester.tap(find.text(tr(LocaleKeys.Login)));
    await tester.pump();

    await tester.tap(find.text(tr(LocaleKeys.ApplyNow)));
    await tester.pump();
  });
}
