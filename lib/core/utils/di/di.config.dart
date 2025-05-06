// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../../data/auth/api/auth_retrofit_client.dart' as _i1064;
import '../../../data/auth/data_source/contract/auth_remote_data_source.dart'
    as _i774;
import '../../../data/auth/data_source/remote/auth_remote_data_source_impl.dart'
    as _i173;
import '../../../data/auth/repo_impl/auth_repo_impl.dart' as _i15;
import '../../../domain/auth/repo/auth_repo.dart' as _i1047;
import '../../../domain/auth/usecase/forget_password_use_case.dart' as _i615;
import '../../../domain/auth/usecase/reset_password_use_case.dart' as _i313;
import '../../../domain/auth/usecase/verify_reset_code_use_case.dart' as _i684;
import '../../../features/forget_password/presentation/view_model/email_verification/email_verification_cubit.dart'
    as _i725;
import '../../../features/forget_password/presentation/view_model/forget_password_cubit/forget_password_cubit.dart'
    as _i3;
import '../../../features/forget_password/presentation/view_model/reset_password/reset_password_cubit.dart'
    as _i216;
import '../bloc_observer/bloc_observer_service.dart' as _i649;
import '../datasource_excution/api_manager.dart' as _i28;
import '../datasource_excution/dio_module.dart' as _i953;
import '../flutter_secure_storage_module.dart' as _i712;
import '../logging/logger_module.dart' as _i470;
import '../shared_preference_module.dart' as _i60;
import '../validator/validator.dart' as _i468;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final sharedPreferenceModule = _$SharedPreferenceModule();
    final secureStorageModule = _$SecureStorageModule();
    final loggerModule = _$LoggerModule();
    final dioModule = _$DioModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => sharedPreferenceModule.sharedPreferences,
      preResolve: true,
    );
    gh.factory<_i468.Validator>(() => _i468.Validator());
    gh.singleton<_i28.ApiManager>(() => _i28.ApiManager());
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => secureStorageModule.storage,
    );
    gh.lazySingleton<_i974.Logger>(() => loggerModule.loggerProvider);
    gh.lazySingleton<_i974.PrettyPrinter>(() => loggerModule.prettyPrinter);
    gh.singleton<_i649.BlocObserverService>(
      () => _i649.BlocObserverService(gh<_i974.Logger>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => dioModule.provideDio(gh<_i558.FlutterSecureStorage>()),
    );
    gh.factory<_i1064.AuthRetrofitClient>(
      () => _i1064.AuthRetrofitClient(gh<_i361.Dio>()),
    );
    gh.factory<_i774.AuthRemoteDataSource>(
      () => _i173.AuthRemoteDataSourceImpl(gh<_i1064.AuthRetrofitClient>()),
    );
    gh.factory<_i1047.AuthRepo>(
      () => _i15.AuthRepoImpl(
        gh<_i28.ApiManager>(),
        gh<_i774.AuthRemoteDataSource>(),
      ),
    );
    gh.factory<_i615.ForgetPasswordUseCase>(
      () => _i615.ForgetPasswordUseCase(gh<_i1047.AuthRepo>()),
    );
    gh.factory<_i313.ResetPasswordUseCase>(
      () => _i313.ResetPasswordUseCase(gh<_i1047.AuthRepo>()),
    );
    gh.factory<_i684.VerifyResetCodeUseCase>(
      () => _i684.VerifyResetCodeUseCase(gh<_i1047.AuthRepo>()),
    );
    gh.factory<_i725.EmailVerificationCubit>(
      () => _i725.EmailVerificationCubit(
        gh<_i684.VerifyResetCodeUseCase>(),
        gh<_i615.ForgetPasswordUseCase>(),
        gh<_i468.Validator>(),
      ),
    );
    gh.factory<_i216.ResetPasswordCubit>(
      () => _i216.ResetPasswordCubit(
        gh<_i313.ResetPasswordUseCase>(),
        gh<_i468.Validator>(),
      ),
    );
    gh.factory<_i3.ForgetPasswordCubit>(
      () => _i3.ForgetPasswordCubit(
        gh<_i615.ForgetPasswordUseCase>(),
        gh<_i468.Validator>(),
      ),
    );
    return this;
  }
}

class _$SharedPreferenceModule extends _i60.SharedPreferenceModule {}

class _$SecureStorageModule extends _i712.SecureStorageModule {}

class _$LoggerModule extends _i470.LoggerModule {}

class _$DioModule extends _i953.DioModule {}
