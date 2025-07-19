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

import '../../../data/auth/api/ai_model_service.dart' as _i422;
import '../../../data/auth/api/apply_api_manager.dart' as _i1054;
import '../../../data/auth/api/apply_api_manager_impl.dart' as _i700;
import '../../../data/auth/api/auth_retrofit_client.dart' as _i1064;
import '../../../data/auth/data_source/contract/auth_local_data_source.dart'
    as _i1063;
import '../../../data/auth/data_source/contract/auth_remote_data_source.dart'
    as _i774;
import '../../../data/auth/data_source/local/auth_local_data_source_impl.dart'
    as _i757;
import '../../../data/auth/data_source/remote/auth_remote_data_source_impl.dart'
    as _i173;
import '../../../data/auth/repo_impl/auth_repo_impl.dart' as _i15;
import '../../../domain/auth/repo/auth_repo.dart' as _i1047;
import '../../../domain/auth/use_case/apply_use_case.dart' as _i13;
import '../../../domain/auth/use_case/extract_data_from_national_id_use_case.dart'
    as _i413;
import '../../../domain/auth/use_case/extract_data_from_vehicle_license_use_case.dart'
    as _i29;
import '../../../domain/auth/use_case/get_all_countries_use_case.dart' as _i488;
import '../../../domain/auth/use_case/get_all_vehicles_use_case.dart' as _i377;
import '../../../domain/auth/use_case/login_use_case.dart' as _i872;
import '../../../domain/auth/usecase/forget_password_use_case.dart' as _i615;
import '../../../domain/auth/usecase/reset_password_use_case.dart' as _i313;
import '../../../domain/auth/usecase/verify_reset_code_use_case.dart' as _i684;
import '../../../features/apply/presentation/view_model/cubit/apply_cubit.dart'
    as _i571;
import '../../../features/forget_password/presentation/view_model/email_verification_cubit/email_verification_cubit.dart'
    as _i296;
import '../../../features/forget_password/presentation/view_model/forget_password_cubit/forget_password_cubit.dart'
    as _i3;
import '../../../features/forget_password/presentation/view_model/reset_password_cubit/reset_password_cubit.dart'
    as _i61;
import '../../../features/login/presentation/view_model/login_cubit.dart'
    as _i638;
import '../../functions/initial_route_function.dart' as _i687;
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
    gh.factory<_i422.AiModelService>(() => _i422.AiModelService());
    gh.singleton<_i28.ApiManager>(() => _i28.ApiManager());
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => secureStorageModule.storage,
    );
    gh.lazySingleton<_i974.Logger>(() => loggerModule.loggerProvider);
    gh.lazySingleton<_i974.PrettyPrinter>(() => loggerModule.prettyPrinter);
    gh.singleton<_i649.BlocObserverService>(
      () => _i649.BlocObserverService(gh<_i974.Logger>()),
    );
    gh.factory<_i687.RouteInitializer>(
      () => _i687.RouteInitializer(
        sharedPreferences: gh<_i460.SharedPreferences>(),
      ),
    );
    gh.lazySingleton<_i361.Dio>(
      () => dioModule.provideDio(gh<_i558.FlutterSecureStorage>()),
    );
    gh.factory<_i1063.AuthLocalDataSource>(
      () => _i757.AuthLocalDataSourceImpl(
        gh<_i558.FlutterSecureStorage>(),
        gh<_i460.SharedPreferences>(),
      ),
    );
    gh.factory<_i1054.ApplyApiManager>(
      () => _i700.ApplyApiManagerImpl(gh<_i361.Dio>()),
    );
    gh.factory<_i1064.AuthRetrofitClient>(
      () => _i1064.AuthRetrofitClient(gh<_i361.Dio>()),
    );
    gh.factory<_i774.AuthRemoteDataSource>(
      () => _i173.AuthRemoteDataSourceImpl(
        gh<_i1064.AuthRetrofitClient>(),
        gh<_i422.AiModelService>(),
        gh<_i1054.ApplyApiManager>(),
      ),
    );
    gh.factory<_i1047.AuthRepo>(
      () => _i15.AuthRepoImpl(
        gh<_i774.AuthRemoteDataSource>(),
        gh<_i1063.AuthLocalDataSource>(),
        gh<_i28.ApiManager>(),
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
    gh.factory<_i413.ExtractDataFromNationalIdUseCase>(
      () => _i413.ExtractDataFromNationalIdUseCase(gh<_i1047.AuthRepo>()),
    );
    gh.factory<_i29.ExtractDataFromVehicleLicenseUseCase>(
      () => _i29.ExtractDataFromVehicleLicenseUseCase(gh<_i1047.AuthRepo>()),
    );
    gh.factory<_i488.GetAllCountriesUseCase>(
      () => _i488.GetAllCountriesUseCase(gh<_i1047.AuthRepo>()),
    );
    gh.factory<_i377.GetAllVehiclesUseCase>(
      () => _i377.GetAllVehiclesUseCase(gh<_i1047.AuthRepo>()),
    );
    gh.factory<_i13.ApplyUseCase>(
      () => _i13.ApplyUseCase(gh<_i1047.AuthRepo>()),
    );
    gh.factory<_i872.LoginUsecase>(
      () => _i872.LoginUsecase(gh<_i1047.AuthRepo>()),
    );
    gh.factory<_i296.EmailVerificationCubit>(
      () => _i296.EmailVerificationCubit(
        gh<_i684.VerifyResetCodeUseCase>(),
        gh<_i615.ForgetPasswordUseCase>(),
        gh<_i468.Validator>(),
      ),
    );
    gh.factory<_i61.ResetPasswordCubit>(
      () => _i61.ResetPasswordCubit(
        gh<_i313.ResetPasswordUseCase>(),
        gh<_i468.Validator>(),
      ),
    );
    gh.factory<_i638.LoginCubit>(
      () => _i638.LoginCubit(gh<_i872.LoginUsecase>(), gh<_i468.Validator>()),
    );
    gh.factory<_i571.ApplyCubit>(
      () => _i571.ApplyCubit(
        gh<_i377.GetAllVehiclesUseCase>(),
        gh<_i488.GetAllCountriesUseCase>(),
        gh<_i29.ExtractDataFromVehicleLicenseUseCase>(),
        gh<_i413.ExtractDataFromNationalIdUseCase>(),
        gh<_i13.ApplyUseCase>(),
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
