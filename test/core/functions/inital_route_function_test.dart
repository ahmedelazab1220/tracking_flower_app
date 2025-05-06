import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracking_flower_app/core/functions/initial_route_function.dart';
import 'package:tracking_flower_app/core/utils/constants.dart';
import 'package:tracking_flower_app/core/utils/routes/app_routes.dart';

import 'inital_route_function_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late RouteInitializer routeInitializer;
  late MockSharedPreferences mockPrefs;

  setUpAll(() {
    mockPrefs = MockSharedPreferences();
    routeInitializer = RouteInitializer(sharedPreferences: mockPrefs);
  });

  group('RouteInitializer', () {
    test('returns onBoarding route when rememberMe is null', () {
      // Arrange
      when(mockPrefs.getBool(Constants.isRememberMe)).thenReturn(null);

      // Act
      final result = routeInitializer.computeInitialRoute();

      // Assert
      expect(result, AppRoutes.onBoardingRoute);
      verify(mockPrefs.getBool(Constants.isRememberMe)).called(1);
    });

    test('returns login route when rememberMe is false', () {
      // Arrange
      when(mockPrefs.getBool(Constants.isRememberMe)).thenReturn(false);

      // Act
      final result = routeInitializer.computeInitialRoute();

      // Assert
      expect(result, AppRoutes.loginRoute);
      verify(mockPrefs.getBool(Constants.isRememberMe)).called(1);
    });

    test('returns login route when rememberMe is true', () {
      // Arrange
      when(mockPrefs.getBool(Constants.isRememberMe)).thenReturn(true);

      // Act
      final result = routeInitializer.computeInitialRoute();

      // Assert
      expect(result, AppRoutes.loginRoute);
      verify(mockPrefs.getBool(Constants.isRememberMe)).called(1);
    });
  });
}
