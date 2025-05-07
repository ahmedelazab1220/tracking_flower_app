import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracking_flower_app/core/utils/constants.dart';
import 'package:tracking_flower_app/data/auth/data_source/local/auth_local_data_source_impl.dart';

import 'auth_local_data_source_impl_test.mocks.dart';

@GenerateMocks([FlutterSecureStorage, SharedPreferences])
void main() {
  late AuthLocalDataSourceImpl authLocalDataSourceImpl;
  late MockFlutterSecureStorage mockFlutterSecureStorage;
  late MockSharedPreferences mockSharedPreferences;

  // Test constants
  const testTokenKey = Constants.token;
  const testRememberMeKey = Constants.isRememberMe;
  const testTokenValue = 'test_auth_token';
  const emptyString = '';

  setUp(() {
    mockFlutterSecureStorage = MockFlutterSecureStorage();
    mockSharedPreferences = MockSharedPreferences();
    authLocalDataSourceImpl = AuthLocalDataSourceImpl(
      mockFlutterSecureStorage,
      mockSharedPreferences,
    );
  });

  group('Token Operations', () {
    test(
      'saveToken should call secure storage with correct parameters and handle success',
      () async {
        // Arrange
        when(
          mockFlutterSecureStorage.write(
            key: anyNamed('key'),
            value: anyNamed('value'),
          ),
        ).thenAnswer((_) => Future.value());

        // Act
        await authLocalDataSourceImpl.saveToken(testTokenKey, testTokenValue);

        // Assert
        verify(
          mockFlutterSecureStorage.write(
            key: testTokenKey,
            value: testTokenValue,
          ),
        ).called(1);
      },
    );

    test('saveToken should propagate storage exceptions', () async {
      // Arrange
      const errorMessage = 'Secure storage write error';
      when(
        mockFlutterSecureStorage.write(
          key: anyNamed('key'),
          value: anyNamed('value'),
        ),
      ).thenThrow(Exception(errorMessage));

      // Act & Assert
      expect(
        () => authLocalDataSourceImpl.saveToken(testTokenKey, testTokenValue),
        throwsA(isA<Exception>()),
      );
      verify(
        mockFlutterSecureStorage.write(
          key: testTokenKey,
          value: testTokenValue,
        ),
      ).called(1);
    });

    test('getToken should return stored token when available', () async {
      // Arrange
      when(
        mockFlutterSecureStorage.read(key: anyNamed('key')),
      ).thenAnswer((_) => Future.value(testTokenValue));

      // Act
      final result = await authLocalDataSourceImpl.getToken(testTokenKey);

      // Assert
      expect(result, testTokenValue);
      verify(mockFlutterSecureStorage.read(key: testTokenKey)).called(1);
    });

    test(
      'getToken should return empty string when token is not available',
      () async {
        // Arrange
        when(
          mockFlutterSecureStorage.read(key: anyNamed('key')),
        ).thenAnswer((_) => Future.value(null));

        // Act
        final result = await authLocalDataSourceImpl.getToken(testTokenKey);

        // Assert
        expect(result, emptyString);
        verify(mockFlutterSecureStorage.read(key: testTokenKey)).called(1);
      },
    );

    test('deleteToken should remove token from secure storage', () async {
      // Arrange
      when(
        mockFlutterSecureStorage.delete(key: anyNamed('key')),
      ).thenAnswer((_) => Future.value());

      // Act
      await authLocalDataSourceImpl.deleteToken(testTokenKey);

      // Assert
      verify(mockFlutterSecureStorage.delete(key: testTokenKey)).called(1);
    });

    test('clearAll should remove all data from secure storage', () async {
      // Arrange
      when(
        mockFlutterSecureStorage.deleteAll(),
      ).thenAnswer((_) => Future.value());

      // Act
      await authLocalDataSourceImpl.clearAll();

      // Assert
      verify(mockFlutterSecureStorage.deleteAll()).called(1);
    });
  });

  group('Remember Me Operations', () {
    test(
      'setRememberMe should store boolean value in shared preferences',
      () async {
        // Arrange
        when(
          mockSharedPreferences.setBool(any, any),
        ).thenAnswer((_) => Future.value(true));

        // Act
        await authLocalDataSourceImpl.setRememberMe(true);
        await authLocalDataSourceImpl.setRememberMe(false);

        // Assert
        verifyInOrder([
          mockSharedPreferences.setBool(testRememberMeKey, true),
          mockSharedPreferences.setBool(testRememberMeKey, false),
        ]);
      },
    );

    test(
      'isRememberMe should return true when enabled in preferences',
      () async {
        // Arrange
        when(mockSharedPreferences.getBool(testRememberMeKey)).thenReturn(true);

        // Act
        final result = await authLocalDataSourceImpl.isRememberMe();

        // Assert
        expect(result, isTrue);
        verify(mockSharedPreferences.getBool(testRememberMeKey)).called(1);
      },
    );

    test(
      'isRememberMe should return false when disabled in preferences',
      () async {
        // Arrange
        when(
          mockSharedPreferences.getBool(testRememberMeKey),
        ).thenReturn(false);

        // Act
        final result = await authLocalDataSourceImpl.isRememberMe();

        // Assert
        expect(result, isFalse);
        verify(mockSharedPreferences.getBool(testRememberMeKey)).called(1);
      },
    );

    test(
      'isRememberMe should return false when preference value is null',
      () async {
        // Arrange
        when(mockSharedPreferences.getBool(testRememberMeKey)).thenReturn(null);

        // Act
        final result = await authLocalDataSourceImpl.isRememberMe();

        // Assert
        expect(result, isFalse);
        verify(mockSharedPreferences.getBool(testRememberMeKey)).called(1);
      },
    );
  });

  group('Error Handling', () {
    test('should propagate secure storage read errors', () async {
      // Arrange
      const errorMessage = 'Secure storage read error';
      when(
        mockFlutterSecureStorage.read(key: anyNamed('key')),
      ).thenThrow(Exception(errorMessage));

      // Act & Assert
      expect(
        () => authLocalDataSourceImpl.getToken(testTokenKey),
        throwsA(isA<Exception>()),
      );
    });

    test('should propagate secure storage delete errors', () async {
      // Arrange
      const errorMessage = 'Secure storage delete error';
      when(
        mockFlutterSecureStorage.delete(key: anyNamed('key')),
      ).thenThrow(Exception(errorMessage));

      // Act & Assert
      expect(
        () => authLocalDataSourceImpl.deleteToken(testTokenKey),
        throwsA(isA<Exception>()),
      );
    });

    test('should propagate shared preferences setBool errors', () async {
      // Arrange
      const errorMessage = 'Shared preferences setBool error';
      when(
        mockSharedPreferences.setBool(any, any),
      ).thenThrow(Exception(errorMessage));

      // Act & Assert
      expect(
        () => authLocalDataSourceImpl.setRememberMe(true),
        throwsA(isA<Exception>()),
      );
    });

    test('should propagate shared preferences getBool errors', () async {
      // Arrange
      const errorMessage = 'Shared preferences getBool error';
      when(
        mockSharedPreferences.getBool(any),
      ).thenThrow(Exception(errorMessage));

      // Act & Assert
      expect(
        () => authLocalDataSourceImpl.isRememberMe(),
        throwsA(isA<Exception>()),
      );
    });
  });
}
