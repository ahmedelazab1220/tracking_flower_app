import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_flower_app/core/base/base_state.dart';
import 'package:tracking_flower_app/core/utils/datasource_excution/api_result.dart';
import 'package:tracking_flower_app/core/utils/validator/validator.dart';
import 'package:tracking_flower_app/domain/auth/entity/login_request_entity.dart';
import 'package:tracking_flower_app/domain/auth/use_case/login_use_case.dart';
import 'package:tracking_flower_app/features/login/presentation/view_model/login_cubit.dart';
import 'package:tracking_flower_app/features/login/presentation/view_model/login_state.dart';

import 'login_cubit_test.mocks.dart';

@GenerateMocks([LoginUsecase, Validator])
void main() {
  late MockLoginUsecase mockLoginUsecase;
  late MockValidator mockValidator;
  late LoginCubit loginCubit;

  setUp(() {
    mockLoginUsecase = MockLoginUsecase();
    mockValidator = MockValidator();
    loginCubit = LoginCubit(mockLoginUsecase, mockValidator);
  });

  tearDown(() {
    loginCubit.close();
  });

  group('LoginCubit', () {
    test(
      'initial state is BaseInitialState, isRememberMe=false, isValidate=false',
      () {
        expect(loginCubit.state.loginState, isA<BaseInitialState>());
        expect(loginCubit.state.isRememberMe, false);
        expect(loginCubit.state.isValidate, false);
      },
    );

    test('emailController and passwordController are initialized', () {
      expect(loginCubit.emailController, isA<TextEditingController>());
      expect(loginCubit.passwordController, isA<TextEditingController>());
    });

    test('formKey is initialized', () {
      expect(loginCubit.formKey, isA<GlobalKey<FormState>>());
    });

    test(
      'doIntent calls _login when action is LoginRequestAction and success',
      () async {
        provideDummy<Result<void>>(SuccessResult<void>(null));

        // Arrange
        const email = "test@example.com";
        const password = "test";
        loginCubit.emailController.text = email;
        loginCubit.passwordController.text = password;
        when(mockValidator.validateEmail(email)).thenReturn(null);
        when(mockValidator.validatePassword(password)).thenReturn(null);
        when(
          mockLoginUsecase.call(
            argThat(
              isA<LoginRequestEntity>()
                  .having((entity) => entity.email, 'email', email)
                  .having((entity) => entity.password, 'password', password),
            ),
          ),
        ).thenAnswer((_) async => SuccessResult<void>(null));

        // Assert Later
        final expected = [
          predicate<LoginState>(
            (state) => state.loginState is BaseLoadingState,
          ),
          predicate<LoginState>(
            (state) => state.loginState is BaseSuccessState,
          ),
        ];

        expectLater(loginCubit.stream, emitsInOrder(expected));

        // Act
        loginCubit.doIntent(LoginRequestAction());
      },
    );

    test(
      'doIntent calls _login when action is LoginRequestAction and failure',
      () async {
        final exception = Exception('Login failed');
        provideDummy<Result<void>>(FailureResult<void>(exception));

        // Arrange
        const email = "test@example.com";
        const password = "test";
        loginCubit.emailController.text = email;
        loginCubit.passwordController.text = password;
        when(mockValidator.validateEmail(email)).thenReturn(null);
        when(mockValidator.validatePassword(password)).thenReturn(null);
        when(
          mockLoginUsecase.call(
            argThat(
              isA<LoginRequestEntity>()
                  .having((entity) => entity.email, 'email', email)
                  .having((entity) => entity.password, 'password', password),
            ),
          ),
        ).thenAnswer((_) async => FailureResult<void>(exception));

        // Assert Later
        final expected = [
          predicate<LoginState>(
            (state) => state.loginState is BaseLoadingState,
          ),
          predicate<LoginState>((state) => state.loginState is BaseErrorState),
        ];

        expectLater(loginCubit.stream, emitsInOrder(expected));

        // Act
        loginCubit.doIntent(LoginRequestAction());
      },
    );
  });
}
