import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_flower_app/core/utils/datasource_excution/api_constants.dart';
import 'package:tracking_flower_app/data/auth/api/auth_retrofit_client.dart';
import 'package:tracking_flower_app/data/auth/data_source/remote/auth_remote_data_source_impl.dart';
import 'package:tracking_flower_app/data/auth/models/forget_password_request_dto.dart';
import 'package:tracking_flower_app/data/auth/models/forget_password_response_dto.dart';
import 'package:tracking_flower_app/data/auth/models/login_request_dto.dart';
import 'package:tracking_flower_app/data/auth/models/login_response_dto.dart';
import 'package:tracking_flower_app/data/auth/models/reset_password_request_dto.dart';
import 'package:tracking_flower_app/data/auth/models/reset_password_response_dto.dart';
import 'package:tracking_flower_app/data/auth/models/verify_reset_code_request_dto.dart';
import 'package:tracking_flower_app/data/auth/models/verify_reset_code_response_dto.dart';

import '../../../../constants_factory.dart';
import 'auth_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([AuthRetrofitClient])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AuthRemoteDataSourceImpl authRemoteDataSourceImpl;
  late MockAuthRetrofitClient mockAuthRetrofitClient;

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
    mockAuthRetrofitClient = MockAuthRetrofitClient();
    authRemoteDataSourceImpl = AuthRemoteDataSourceImpl(mockAuthRetrofitClient);
  });

  group('login', () {
    test(
      'should return LoginResponseDto when the login call is successful',
      () async {
        // Arrange
        final successResponse = LoginResponseDto(token: 'token');
        provideDummy<LoginResponseDto>(successResponse);
        when(
          mockAuthRetrofitClient.login(loginRequest),
        ).thenAnswer((_) async => successResponse);

        // Act
        final result = await authRemoteDataSourceImpl.login(loginRequest);

        // Assert
        expect(result, equals(successResponse));
        expect(result.token, equals(successResponse.token));
        verify(mockAuthRetrofitClient.login(loginRequest)).called(1);
        verifyNoMoreInteractions(mockAuthRetrofitClient);
      },
    );

    test(
      'should throw a network error when there is a network failure (SocketException)',
      () async {
        // Arrange
        when(
          mockAuthRetrofitClient.login(loginRequest),
        ).thenThrow(const SocketException(ConstantsFactory.networkError));

        // Act & Assert
        expect(
          () => authRemoteDataSourceImpl.login(loginRequest),
          throwsA(isA<SocketException>()),
        );
        verify(mockAuthRetrofitClient.login(loginRequest)).called(1);
        verifyNoMoreInteractions(mockAuthRetrofitClient);
      },
    );

    test(
      'should throw a timeout error when the login call takes longer than the timeout',
      () async {
        // Arrange
        when(mockAuthRetrofitClient.login(loginRequest)).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ApiConstants.login),
            type: DioExceptionType.connectionTimeout,
          ),
        );

        // Act & Assert
        expect(
          () => authRemoteDataSourceImpl.login(loginRequest),
          throwsA(
            isA<DioException>().having(
              (e) => e.type,
              type,
              DioExceptionType.connectionTimeout,
            ),
          ),
        );
        verify(mockAuthRetrofitClient.login(loginRequest)).called(1);
        verifyNoMoreInteractions(mockAuthRetrofitClient);
      },
    );

    test(
      'should throw an error when the login call returns an authentication error (401)',
      () async {
        // Arrange
        when(mockAuthRetrofitClient.login(invalidCredentialsRequest)).thenThrow(
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
          () => authRemoteDataSourceImpl.login(invalidCredentialsRequest),
          throwsA(
            isA<DioException>().having(
              (e) => e.response?.statusCode,
              statusCode,
              ConstantsFactory.unauthorizedStatusCode,
            ),
          ),
        );
        verify(
          mockAuthRetrofitClient.login(invalidCredentialsRequest),
        ).called(1);
        verifyNoMoreInteractions(mockAuthRetrofitClient);
      },
    );

    test(
      'should throw an error when the login call returns a forbidden error (403)',
      () async {
        // Arrange
        when(mockAuthRetrofitClient.login(loginRequest)).thenThrow(
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
          () => authRemoteDataSourceImpl.login(loginRequest),
          throwsA(
            isA<DioException>().having(
              (e) => e.response?.statusCode,
              statusCode,
              ConstantsFactory.forbiddenStatusCode,
            ),
          ),
        );
        verify(mockAuthRetrofitClient.login(loginRequest)).called(1);
        verifyNoMoreInteractions(mockAuthRetrofitClient);
      },
    );

    test(
      'should throw an error when the login call returns a client error (404)',
      () async {
        // Arrange
        when(mockAuthRetrofitClient.login(loginRequest)).thenThrow(
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
          () => authRemoteDataSourceImpl.login(loginRequest),
          throwsA(
            isA<DioException>().having(
              (e) => e.response?.statusCode,
              statusCode,
              ConstantsFactory.clientErrorStatusCode,
            ),
          ),
        );
        verify(mockAuthRetrofitClient.login(loginRequest)).called(1);
        verifyNoMoreInteractions(mockAuthRetrofitClient);
      },
    );

    test(
      'should handle missing fields in the API response gracefully',
      () async {
        // Arrange
        final emptyResponse = LoginResponseDto();
        when(
          mockAuthRetrofitClient.login(loginRequest),
        ).thenAnswer((_) async => emptyResponse);

        // Act
        final result = await authRemoteDataSourceImpl.login(loginRequest);

        // Assert
        expect(result, equals(emptyResponse));
        expect(result.token, isNull);
        verify(mockAuthRetrofitClient.login(loginRequest)).called(1);
        verifyNoMoreInteractions(mockAuthRetrofitClient);
      },
    );
  });

  group("Auth Remote Data Source Test", () {
    test("forgetPassword should call the correct method", () async {
      // Arrange
      final requestDto = ForgetPasswordRequestDto(email: "test@example.com");
      when(
        mockAuthRetrofitClient.forgetPassword(requestDto),
      ).thenAnswer((_) async => ForgetPasswordResponseDto());

      // Act
      final result = await authRemoteDataSourceImpl.forgetPassword(requestDto);

      // Assert
      verify(mockAuthRetrofitClient.forgetPassword(requestDto)).called(1);
      expect(result, isA<ForgetPasswordResponseDto>());
    });

    test("verifyResetCode should call the correct method", () async {
      // Arrange
      final requestDto = VerifyResetCodeRequestDto(resetCode: '123456');
      when(
        mockAuthRetrofitClient.verifyResetCode(requestDto),
      ).thenAnswer((_) async => VerifyResetCodeResponseDto());

      // Act
      final result = await authRemoteDataSourceImpl.verifyResetCode(requestDto);

      // Assert
      verify(mockAuthRetrofitClient.verifyResetCode(requestDto)).called(1);
      expect(result, isA<VerifyResetCodeResponseDto>());
    });

    test("resetPassword should call the correct method", () async {
      // Arrange
      final requestDto = ResetPasswordRequestDto(
        email: 'test@example.com',
        newPassword: 'Test@123',
      );
      when(
        mockAuthRetrofitClient.resetPassword(requestDto),
      ).thenAnswer((_) async => ResetPasswordResponseDto());

      // Act
      final result = await authRemoteDataSourceImpl.resetPassword(requestDto);

      // Assert
      verify(mockAuthRetrofitClient.resetPassword(requestDto)).called(1);
      expect(result, isA<ResetPasswordResponseDto>());
    });
  });
}
