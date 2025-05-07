import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_flower_app/data/auth/api/auth_retrofit_client.dart';
import 'package:tracking_flower_app/data/auth/data_source/remote/auth_remote_data_source_impl.dart';
import 'package:tracking_flower_app/data/auth/models/forget_password_request_dto.dart';
import 'package:tracking_flower_app/data/auth/models/forget_password_response_dto.dart';
import 'package:tracking_flower_app/data/auth/models/reset_password_request_dto.dart';
import 'package:tracking_flower_app/data/auth/models/reset_password_response_dto.dart';
import 'package:tracking_flower_app/data/auth/models/verify_reset_code_request_dto.dart';
import 'package:tracking_flower_app/data/auth/models/verify_reset_code_response_dto.dart';

import 'auth_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([AuthRetrofitClient])
void main() {
  late AuthRemoteDataSourceImpl authRemoteDataSourceImpl;
  late MockAuthRetrofitClient mockAuthRetrofitClient;

  setUp(() {
    mockAuthRetrofitClient = MockAuthRetrofitClient();
    authRemoteDataSourceImpl = AuthRemoteDataSourceImpl(mockAuthRetrofitClient);
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
