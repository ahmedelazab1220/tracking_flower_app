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

import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([ApiManager, AuthRemoteDataSource])
void main() {
  late AuthRepoImpl authRepoImpl;
  late MockApiManager mockApiManager;
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;

  setUp(() {
    mockApiManager = MockApiManager();
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    authRepoImpl = AuthRepoImpl(mockApiManager, mockAuthRemoteDataSource);
  });

  group("Auth Repo Test", () {
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
