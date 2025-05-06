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

  setUp(() {
    mockFlutterSecureStorage = MockFlutterSecureStorage();
    mockSharedPreferences = MockSharedPreferences();
    authLocalDataSourceImpl = AuthLocalDataSourceImpl(
      mockFlutterSecureStorage,
      mockSharedPreferences,
    );
  });

  group('AuthLocalDataSourceImpl', () {
    group('saveToken', () {
      test(
        'should call write method of FlutterSecureStorage with correct arguments',
        () async {
          // Arrange
          const key = Constants.token;
          const value = 'test_token';
          when(
            mockFlutterSecureStorage.write(key: key, value: value),
          ).thenAnswer((_) async {});

          // Act
          // Assert
          expect(
            () => authLocalDataSourceImpl.saveToken(key, value),
            returnsNormally,
          );
        },
      );

      test(
        'should throw Exception when write method of FlutterSecureStorage fails',
        () async {
          // Arrange
          const key = Constants.token;
          const value = 'test_token';
          when(
            mockFlutterSecureStorage.write(key: key, value: value),
          ).thenThrow(Exception('Failed to write'));

          // Act
          // Assert
          expect(
            () => authLocalDataSourceImpl.saveToken(key, value),
            throwsA(isA<Exception>()),
          );
        },
      );
    });

    group('getToken', () {
      test(
        'should call read method of FlutterSecureStorage with correct arguments',
        () async {
          // Arrange
          const key = Constants.token;
          const value = 'test_token';
          when(
            mockFlutterSecureStorage.read(key: key),
          ).thenAnswer((_) async => value);

          // Act
          final result = await authLocalDataSourceImpl.getToken(key);

          // Assert
          expect(result, value);
        },
      );

      test(
        'should return null when read method of FlutterSecureStorage returns null',
        () async {
          // Arrange
          const key = Constants.token;
          const value = null;
          when(
            mockFlutterSecureStorage.read(key: key),
          ).thenAnswer((_) async => value);

          // Act
          final result = await authLocalDataSourceImpl.getToken(key);

          // Assert
          expect(result, '');
        },
      );

      test(
        'should throw Exception when read method of FlutterSecureStorage fails',
        () async {
          // Arrange
          const key = Constants.token;
          when(
            mockFlutterSecureStorage.read(key: key),
          ).thenThrow(Exception('Failed to read'));

          // Act
          // Assert
          expect(
            () => authLocalDataSourceImpl.getToken(key),
            throwsA(isA<Exception>()),
          );
        },
      );
    });

    group('deleteToken', () {
      test(
        'should call delete method of FlutterSecureStorage with correct arguments',
        () async {
          // Arrange
          const key = Constants.token;
          when(
            mockFlutterSecureStorage.delete(key: key),
          ).thenAnswer((_) async {});

          // Act
          // Assert
          expect(
            () => authLocalDataSourceImpl.deleteToken(key),
            returnsNormally,
          );
        },
      );

      test(
        'should throw Exception when delete method of FlutterSecureStorage fails',
        () async {
          // Arrange
          const key = Constants.token;
          when(
            mockFlutterSecureStorage.delete(key: key),
          ).thenThrow(Exception('Failed to delete'));

          // Act
          // Assert
          expect(
            () => authLocalDataSourceImpl.deleteToken(key),
            throwsA(isA<Exception>()),
          );
        },
      );
    });

    group('clearAll', () {
      test('should call deleteAll method of FlutterSecureStorage', () async {
        // Arrange
        when(mockFlutterSecureStorage.deleteAll()).thenAnswer((_) async {});

        // Act
        // Assert
        expect(() => authLocalDataSourceImpl.clearAll(), returnsNormally);
      });

      test(
        'should throw Exception when deleteAll method of FlutterSecureStorage fails',
        () async {
          // Arrange
          when(
            mockFlutterSecureStorage.deleteAll(),
          ).thenThrow(Exception('Failed to delete all'));

          // Act
          // Assert
          expect(
            () => authLocalDataSourceImpl.clearAll(),
            throwsA(isA<Exception>()),
          );
        },
      );
    });

    group('RememberMe', () {
      test(
        'should call setBool method of SharedPreferences and save true',
        () async {
          // Arrange
          const key = Constants.isRememberMe;
          const value = true;
          when(
            mockSharedPreferences.setBool(key, value),
          ).thenAnswer((_) async => true);

          // Act
          // Assert
          expect(
            () => authLocalDataSourceImpl.setRememberMe(value),
            returnsNormally,
          );
        },
      );

      test(
        'should call getBool method of SharedPreferences and return true',
        () async {
          // Arrange
          const key = Constants.isRememberMe;
          const value = true;
          when(mockSharedPreferences.getBool(key)).thenReturn(value);

          // Act
          final result = await authLocalDataSourceImpl.isRememberMe();

          // Assert
          expect(result, value);
        },
      );

      test(
        'should call setBool method of SharedPreferences and return false',
        () async {
          // Arrange
          const key = Constants.isRememberMe;
          const value = false;
          when(
            mockSharedPreferences.setBool(key, value),
          ).thenAnswer((_) async => value);

          // Act
          // Assert
          expect(
            () => authLocalDataSourceImpl.setRememberMe(value),
            returnsNormally,
          );
        },
      );

      test(
        'should call getBool method of SharedPreferences and return false',
        () async {
          // Arrange
          const key = Constants.isRememberMe;
          const value = false;
          when(mockSharedPreferences.getBool(key)).thenReturn(value);

          // Act
          final result = await authLocalDataSourceImpl.isRememberMe();

          // Assert
          expect(result, value);
        },
      );

      test(
        'should throw Exception when setBool method of SharedPreferences fails',
        () async {
          // Arrange
          const key = Constants.isRememberMe;
          const value = true;
          when(
            mockSharedPreferences.setBool(key, value),
          ).thenThrow(Exception('Failed to set bool'));

          // Act
          // Assert
          expect(
            () => authLocalDataSourceImpl.setRememberMe(value),
            throwsA(isA<Exception>()),
          );
        },
      );

      test(
        'should throw Exception when getBool method of SharedPreferences fails',
        () async {
          // Arrange
          const key = Constants.isRememberMe;
          when(
            mockSharedPreferences.getBool(key),
          ).thenThrow(Exception('Failed to get bool'));

          // Act
          // Assert
          expect(
            () => authLocalDataSourceImpl.isRememberMe(),
            throwsA(isA<Exception>()),
          );
        },
      );
    });
  });
}
