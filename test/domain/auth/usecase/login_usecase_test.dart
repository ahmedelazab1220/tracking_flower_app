import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_flower_app/core/utils/datasource_excution/api_result.dart';
import 'package:tracking_flower_app/data/auth/models/login_response_dto.dart';
import 'package:tracking_flower_app/domain/auth/entity/login_request_entity.dart';
import 'package:tracking_flower_app/domain/auth/repo/auth_repo.dart';
import 'package:tracking_flower_app/domain/auth/usecase/login_usecase.dart';

import 'login_usecase_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {
  late MockAuthRepo mockAuthRepo;
  late LoginUsecase loginUsecase;

  setUp(() {
    mockAuthRepo = MockAuthRepo();
    loginUsecase = LoginUsecase(mockAuthRepo);
  });

  group('LoginUsecase', () {
    test(
      'should call login method of AuthRepo with correct parameters',
      () async {
        // Arrange
        final request = LoginRequestEntity(
          email: 'test@example.com',
          password: 'test',
          isRememberMe: true,
        );
        final response = LoginResponseDto(
          message: 'success',
          token: 'test_token',
        );
        provideDummy<Result<void>>(SuccessResult<void>(null));

        when(
          mockAuthRepo.login(request),
        ).thenAnswer((_) async => SuccessResult<LoginResponseDto>(response));
        // Act
        final result = await loginUsecase(request);
        // Assert
        expect(result, isA<SuccessResult<LoginResponseDto>>());
      },
    );

    test('should return failure when login method of AuthRepo fails', () async {
      // Arrange
      final request = LoginRequestEntity(
        email: 'test@example.com',
        password: 'test',
        isRememberMe: true,
      );
      final exception = Exception('Login failed');
      provideDummy<Result<void>>(FailureResult<void>(exception));
      when(
        mockAuthRepo.login(request),
      ).thenAnswer((_) async => FailureResult<LoginResponseDto>(exception));

      // Act
      final result = await loginUsecase(request);

      // Assert
      expect(result, isA<FailureResult<LoginResponseDto>>());
    });
  });
}
