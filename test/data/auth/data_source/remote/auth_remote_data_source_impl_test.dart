import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_flower_app/core/utils/datasource_excution/api_constants.dart';
import 'package:tracking_flower_app/data/auth/api/auth_retrofit_client.dart';
import 'package:tracking_flower_app/data/auth/data_source/remote/auth_remote_data_source_impl.dart';
import 'package:tracking_flower_app/data/auth/models/login_request_dto.dart';
import 'package:tracking_flower_app/data/auth/models/login_response_dto.dart';

import '../../../../constants_factory.dart';
import 'auth_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([AuthRetrofitClient])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AuthRemoteDataSourceImpl remoteDataSource;
  late MockAuthRetrofitClient mockRetrofitClient;

  // Test data
  const validEmail = 'valid@example.com';
  const validPassword = 'validPassword123';
  const invalidEmail = 'invalid@example.com';
  const invalidPassword = 'wrong';
  const type = 'type';
  const statusCode = 'statusCode';

  final loginRequest = LoginRequestDto(
    email: validEmail,
    password: validPassword,
  );

  final invalidCredentialsRequest = LoginRequestDto(
    email: invalidEmail,
    password: invalidPassword,
  );

  setUp(() {
    mockRetrofitClient = MockAuthRetrofitClient();
    remoteDataSource = AuthRemoteDataSourceImpl(mockRetrofitClient);
  });

  group('login', () {
    test(
      'should return LoginResponseDto when the login call is successful',
      () async {
        // Arrange
        final successResponse = LoginResponseDto(token: 'token');
        provideDummy<LoginResponseDto>(successResponse);
        when(
          mockRetrofitClient.login(loginRequest),
        ).thenAnswer((_) async => successResponse);

        // Act
        final result = await remoteDataSource.login(loginRequest);

        // Assert
        expect(result, equals(successResponse));
        expect(result.token, equals(successResponse.token));
        verify(mockRetrofitClient.login(loginRequest)).called(1);
        verifyNoMoreInteractions(mockRetrofitClient);
      },
    );

    test(
      'should throw a network error when there is a network failure (SocketException)',
      () async {
        // Arrange
        when(
          mockRetrofitClient.login(loginRequest),
        ).thenThrow(const SocketException(ConstantsFactory.networkError));

        // Act & Assert
        expect(
          () => remoteDataSource.login(loginRequest),
          throwsA(isA<SocketException>()),
        );
        verify(mockRetrofitClient.login(loginRequest)).called(1);
        verifyNoMoreInteractions(mockRetrofitClient);
      },
    );

    test(
      'should throw a timeout error when the login call takes longer than the timeout',
      () async {
        // Arrange
        when(mockRetrofitClient.login(loginRequest)).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ApiConstants.login),
            type: DioExceptionType.connectionTimeout,
          ),
        );

        // Act & Assert
        expect(
          () => remoteDataSource.login(loginRequest),
          throwsA(
            isA<DioException>().having(
              (e) => e.type,
              type,
              DioExceptionType.connectionTimeout,
            ),
          ),
        );
        verify(mockRetrofitClient.login(loginRequest)).called(1);
        verifyNoMoreInteractions(mockRetrofitClient);
      },
    );

    test(
      'should throw an error when the login call returns an authentication error (401)',
      () async {
        // Arrange
        when(mockRetrofitClient.login(invalidCredentialsRequest)).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ApiConstants.login),
            response: Response(
              requestOptions: RequestOptions(path: ApiConstants.login),
              statusCode: ConstantsFactory.unauthorizedStatusCode,
              data: ConstantsFactory.unauthorized,
            ),
            type: DioExceptionType.badResponse,
          ),
        );

        // Act & Assert
        expect(
          () => remoteDataSource.login(invalidCredentialsRequest),
          throwsA(
            isA<DioException>().having(
              (e) => e.response?.statusCode,
              statusCode,
              ConstantsFactory.unauthorizedStatusCode,
            ),
          ),
        );
        verify(mockRetrofitClient.login(invalidCredentialsRequest)).called(1);
        verifyNoMoreInteractions(mockRetrofitClient);
      },
    );

    test(
      'should throw an error when the login call returns a forbidden error (403)',
      () async {
        // Arrange
        when(mockRetrofitClient.login(loginRequest)).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ApiConstants.login),
            response: Response(
              requestOptions: RequestOptions(path: ApiConstants.login),
              statusCode: ConstantsFactory.forbiddenStatusCode,
              data: ConstantsFactory.forbidden,
            ),
            type: DioExceptionType.badResponse,
          ),
        );

        // Act & Assert
        expect(
          () => remoteDataSource.login(loginRequest),
          throwsA(
            isA<DioException>().having(
              (e) => e.response?.statusCode,
              statusCode,
              ConstantsFactory.forbiddenStatusCode,
            ),
          ),
        );
        verify(mockRetrofitClient.login(loginRequest)).called(1);
        verifyNoMoreInteractions(mockRetrofitClient);
      },
    );

    test(
      'should throw an error when the login call returns a client error (404)',
      () async {
        // Arrange
        when(mockRetrofitClient.login(loginRequest)).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ApiConstants.login),
            response: Response(
              requestOptions: RequestOptions(path: ApiConstants.login),
              statusCode: ConstantsFactory.clientErrorStatusCode,
              data: ConstantsFactory.notFound,
            ),
            type: DioExceptionType.badResponse,
          ),
        );

        // Act & Assert
        expect(
          () => remoteDataSource.login(loginRequest),
          throwsA(
            isA<DioException>().having(
              (e) => e.response?.statusCode,
              statusCode,
              ConstantsFactory.clientErrorStatusCode,
            ),
          ),
        );
        verify(mockRetrofitClient.login(loginRequest)).called(1);
        verifyNoMoreInteractions(mockRetrofitClient);
      },
    );

    test(
      'should handle missing fields in the API response gracefully',
      () async {
        // Arrange
        final emptyResponse = LoginResponseDto();
        when(
          mockRetrofitClient.login(loginRequest),
        ).thenAnswer((_) async => emptyResponse);

        // Act
        final result = await remoteDataSource.login(loginRequest);

        // Assert
        expect(result, equals(emptyResponse));
        expect(result.token, isNull);
        verify(mockRetrofitClient.login(loginRequest)).called(1);
        verifyNoMoreInteractions(mockRetrofitClient);
      },
    );
  });
}
