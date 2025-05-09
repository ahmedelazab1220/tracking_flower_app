import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_flower_app/core/utils/datasource_excution/api_manager.dart';
import 'package:tracking_flower_app/core/utils/datasource_excution/api_result.dart';
import 'package:tracking_flower_app/data/auth/data_source/contract/auth_remote_data_source.dart';
import 'package:tracking_flower_app/data/auth/models/forget_password_request_dto.dart';
import 'package:tracking_flower_app/data/auth/models/forget_password_response_dto.dart';
import 'package:tracking_flower_app/data/auth/models/reset_password_request_dto.dart';
import 'package:tracking_flower_app/data/auth/models/reset_password_response_dto.dart';
import 'package:tracking_flower_app/data/auth/models/verify_reset_code_request_dto.dart';
import 'package:tracking_flower_app/data/auth/models/verify_reset_code_response_dto.dart';
import 'package:tracking_flower_app/data/auth/repo_impl/auth_repo_impl.dart';
import 'package:tracking_flower_app/data/auth/data_source/contract/auth_local_data_source.dart';
import 'package:tracking_flower_app/data/auth/models/login_request_dto.dart';
import 'package:tracking_flower_app/data/auth/models/login_response_dto.dart';
import 'package:tracking_flower_app/domain/auth/entity/login_request_entity.dart';

import '../../../constants_factory.dart';
import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSource, AuthLocalDataSource, ApiManager])
void main() {
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;
  late MockAuthLocalDataSource mockAuthLocalDataSource;
  late MockApiManager mockApiManager;
  late AuthRepoImpl authRepoImpl;

  setUp(() {
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    mockAuthLocalDataSource = MockAuthLocalDataSource();
    mockApiManager = MockApiManager();
    authRepoImpl = AuthRepoImpl(
      mockAuthRemoteDataSource,
      mockAuthLocalDataSource,
      mockApiManager,
    );
  });

  group('AuthRepoImpl Login Test', () {
    test(
      'login should call remote data source and save token and remember me',
      () async {
        // Arrange
        final request = LoginRequestDto(
          email: 'test@example.com',
          password: 'test',
        );
        final entity = LoginRequestEntity(
          email: request.email,
          password: request.password,
          isRememberMe: true,
        );
        final response = LoginResponseDto(
          message: 'success',
          token: 'test_token',
        );
        provideDummy<Result<LoginResponseDto>>(
          SuccessResult<LoginResponseDto>(response),
        );
        provideDummy<Result<dynamic>>(
          SuccessResult<LoginResponseDto>(response),
        );
        when(mockApiManager.execute<LoginResponseDto>(any)).thenAnswer((
          inv,
        ) async {
          final callback =
              inv.positionalArguments[0] as Future<LoginResponseDto> Function();
          final dto = await callback();
          return SuccessResult(dto);
        });
        when(
          mockAuthRemoteDataSource.login(
            argThat(
              predicate<LoginRequestDto>(
                (dto) =>
                    dto.email == request.email &&
                    dto.password == request.password,
              ),
            ),
          ),
        ).thenAnswer((_) async => response);
        when(
          mockAuthLocalDataSource.saveToken(
            ConstantsFactory.token,
            response.token!,
          ),
        ).thenAnswer((_) async {});
        when(
          mockAuthLocalDataSource.setRememberMe(entity.isRememberMe),
        ).thenAnswer((_) async {});

        // Act
        final result = await authRepoImpl.login(entity);

        // Assert
        verify(
          mockAuthRemoteDataSource.login(
            argThat(
              predicate<LoginRequestDto>(
                (dto) =>
                    dto.email == request.email &&
                    dto.password == request.password,
              ),
            ),
          ),
        ).called(1);
        verify(
          mockAuthLocalDataSource.saveToken(
            ConstantsFactory.token,
            response.token!,
          ),
        ).called(1);
        verify(
          mockAuthLocalDataSource.setRememberMe(entity.isRememberMe),
        ).called(1);
        expect(result, isA<SuccessResult<LoginResponseDto>>());
      },
    );

    test(
      'when remote.login throws should return FailureResult and not call local',
      () async {
        // Arrange
        final request = LoginRequestDto(
          email: 'test@example.com',
          password: 'test',
        );
        final entity = LoginRequestEntity(
          email: request.email,
          password: request.password,
          isRememberMe: true,
        );
        final response = LoginResponseDto(
          message: 'success',
          token: 'test_token',
        );
        provideDummy<Result<LoginResponseDto>>(
          SuccessResult<LoginResponseDto>(response),
        );
        provideDummy<Result<dynamic>>(
          SuccessResult<LoginResponseDto>(response),
        );
        final exception = Exception('some exception');
        when(mockApiManager.execute<LoginResponseDto>(any)).thenAnswer((
          inv,
        ) async {
          final callback =
              inv.positionalArguments[0] as Future<LoginResponseDto> Function();
          try {
            final dto = await callback();
            return SuccessResult(dto);
          } catch (e) {
            return FailureResult(exception);
          }
        });
        when(mockAuthRemoteDataSource.login(request)).thenThrow(exception);

        // Act
        final result = await authRepoImpl.login(entity);

        // Assert
        verify(
          mockAuthRemoteDataSource.login(
            argThat(
              predicate<LoginRequestDto>(
                (dto) =>
                    dto.email == request.email &&
                    dto.password == request.password,
              ),
            ),
          ),
        ).called(1);
        verifyZeroInteractions(mockAuthLocalDataSource);
        expect(result, isA<FailureResult<LoginResponseDto>>());
      },
    );

    test(
      'when ApiManager.execute throws should bubble up and not call remote/local',
      () {
        // Arrange
        final entity = LoginRequestEntity(
          email: 'test@example.com',
          password: 'test',
          isRememberMe: false,
        );
        final exception = Exception('executor crashed');
        provideDummy<Result<LoginResponseDto>>(FailureResult(exception));
        when(
          mockApiManager.execute<LoginResponseDto>(any),
        ).thenThrow(exception);

        // Act
        // Assert
        verifyZeroInteractions(mockAuthRemoteDataSource);
        verifyZeroInteractions(mockAuthLocalDataSource);
        expect(() => authRepoImpl.login(entity), throwsA(same(exception)));
      },
    );
  });

  group("AuthRepoImpl Forget Password Test", () {
    test("Forget Password Test", () async {
      provideDummy<Result<void>>(SuccessResult<void>(null));
      provideDummy<Result<dynamic>>(SuccessResult<void>(null));

      // Arrange
      final requestDto = ForgetPasswordRequestDto(email: "test@example.com");
      when(
        mockApiManager.execute(any),
      ).thenAnswer((_) async => SuccessResult<void>(null));

      when(
        mockAuthRemoteDataSource.forgetPassword(requestDto),
      ).thenAnswer((_) async => ForgetPasswordResponseDto());

      // Act
      final result = await authRepoImpl.forgetPassword(requestDto);

      // Assert
      expect(result, isA<SuccessResult<void>>());
    });

    test("Verify Reset Code Test", () async {
      provideDummy<Result<void>>(SuccessResult<void>(null));
      provideDummy<Result<dynamic>>(SuccessResult<void>(null));

      // Arrange
      final requestDto = VerifyResetCodeRequestDto(resetCode: '123456');
      when(
        mockApiManager.execute(any),
      ).thenAnswer((_) async => SuccessResult<void>(null));

      when(
        mockAuthRemoteDataSource.verifyResetCode(requestDto),
      ).thenAnswer((_) async => VerifyResetCodeResponseDto());

      // Act
      final result = await authRepoImpl.verifyResetCode(requestDto);

      // Assert
      expect(result, isA<SuccessResult<void>>());
    });

    test("Reset Password Test", () async {
      provideDummy<Result<void>>(SuccessResult<void>(null));
      provideDummy<Result<dynamic>>(SuccessResult<void>(null));

      // Arrange
      final requestDto = ResetPasswordRequestDto(
        email: "test@example.com",
        newPassword: "Test@123",
      );
      when(
        mockApiManager.execute(any),
      ).thenAnswer((_) async => SuccessResult<void>(null));

      when(
        mockAuthRemoteDataSource.resetPassword(requestDto),
      ).thenAnswer((_) async => ResetPasswordResponseDto());

      // Act
      final result = await authRepoImpl.resetPassword(requestDto);

      // Assert
      expect(result, isA<SuccessResult<void>>());
    });
  });
}
