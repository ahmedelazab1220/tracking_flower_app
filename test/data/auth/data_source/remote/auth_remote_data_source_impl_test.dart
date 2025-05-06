import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_flower_app/data/auth/api/auth_retrofit_client.dart';
import 'package:tracking_flower_app/data/auth/data_source/remote/auth_remote_data_source_impl.dart';
import 'package:tracking_flower_app/data/auth/models/login_request_dto.dart';
import 'package:tracking_flower_app/data/auth/models/login_response_dto.dart';

import 'auth_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([AuthRetrofitClient])
void main() {
  late AuthRemoteDataSourceImpl authRemoteDataSourceImpl;
  late MockAuthRetrofitClient mockAuthRetrofitClient;

  setUp(() {
    mockAuthRetrofitClient = MockAuthRetrofitClient();
    authRemoteDataSourceImpl = AuthRemoteDataSourceImpl(mockAuthRetrofitClient);
  });

  group('AuthRemoteDataSourceImpl', () {
    group('login', () {
      test(
        'should call login method of AuthRetrofitClient with correct arguments',
        () async {
          // Arrange
          final request = LoginRequestDto(
            email: 'test@example.com',
            password: 'test',
          );
          when(
            mockAuthRetrofitClient.login(request),
          ).thenAnswer((_) async => LoginResponseDto());

          // Act
          final result = await authRemoteDataSourceImpl.login(request);

          // Assert
          expect(result, isA<LoginResponseDto>());
        },
      );

      test(
        'should return exception when login method of AuthRetrofitClient fails',
        () async {
          // Arrange
          final request = LoginRequestDto(
            email: 'test@example.com',
            password: 'test',
          );
          when(
            mockAuthRetrofitClient.login(request),
          ).thenThrow(Exception('Login failed'));

          // Act
          final result = authRemoteDataSourceImpl.login(request);

          // Assert
          expect(result, throwsA(isA<Exception>()));
        },
      );
    });
  });
}
