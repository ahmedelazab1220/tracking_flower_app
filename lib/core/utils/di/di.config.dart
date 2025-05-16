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
import '../../../data/auth/data_source/contract/auth_local_data_source.dart'
    as _i1063;
import '../../../data/auth/data_source/contract/auth_remote_data_source.dart'
    as _i774;
import '../../../data/auth/data_source/local/auth_local_data_source_impl.dart'
    as _i757;
import '../../../data/auth/data_source/remote/auth_remote_data_source_impl.dart'
    as _i173;
import '../../../data/auth/repo_impl/auth_repo_impl.dart' as _i15;
import '../../../data/order/api/orders_retrofit_client.dart' as _i873;
import '../../../data/order/data_source/contract/order_item_remote_data_source.dart'
    as _i931;
import '../../../data/order/data_source/contract/orders_remote_data_source.dart'
    as _i1041;
import '../../../data/order/data_source/contract/store_remote_data_source.dart'
    as _i293;
import '../../../data/order/data_source/contract/user_remote_data_source.dart'
    as _i481;
import '../../../data/order/data_source/remote/order_item_remote_data_source_impl.dart'
    as _i726;
import '../../../data/order/data_source/remote/orders_remote_data_source_impl.dart'
    as _i438;
import '../../../data/order/data_source/remote/store_remote_data_source_impl.dart'
    as _i471;
import '../../../data/order/data_source/remote/user_remote_data_source_impl.dart'
    as _i508;
import '../../../domain/auth/repo/auth_repo.dart' as _i1047;
import '../../../domain/auth/use_case/login_use_case.dart' as _i872;
import '../../../domain/auth/usecase/forget_password_use_case.dart' as _i615;
import '../../../domain/auth/usecase/reset_password_use_case.dart' as _i313;
import '../../../domain/auth/usecase/verify_reset_code_use_case.dart' as _i684;
import '../../../domain/order/repo/order_item_repo.dart' as _i907;
import '../../../domain/order/repo/orders_repo.dart' as _i1011;
import '../../../domain/order/repo/store_repo.dart' as _i371;
import '../../../domain/order/repo/user_repo.dart' as _i558;
import '../../../domain/order/usecase/get_order_item_usecase.dart' as _i761;
import '../../../domain/order/usecase/get_orders_usecase.dart' as _i847;
import '../../../domain/order/usecase/get_store_usecase.dart' as _i443;
import '../../../domain/order/usecase/get_user_usecase.dart' as _i563;
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
    gh.singleton<_i28.ApiManager>(() => _i28.ApiManager());
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => secureStorageModule.storage,
    );
    gh.lazySingleton<_i974.Logger>(() => loggerModule.loggerProvider);
    gh.lazySingleton<_i974.PrettyPrinter>(() => loggerModule.prettyPrinter);
    gh.singleton<_i649.BlocObserverService>(
      () => _i649.BlocObserverService(gh<_i974.Logger>()),
    );
    gh.factory<_i563.GetUserUsecase>(
      () => _i563.GetUserUsecase(gh<_i558.UserRepo>()),
    );
    gh.factory<_i761.GetOrderItemUsecase>(
      () => _i761.GetOrderItemUsecase(gh<_i907.OrderItemRepo>()),
    );
    gh.factory<_i847.GetOrdersUsecase>(
      () => _i847.GetOrdersUsecase(gh<_i1011.OrdersRepo>()),
    );
    gh.factory<_i443.GetStoreUsecase>(
      () => _i443.GetStoreUsecase(gh<_i371.StoreRepo>()),
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
    gh.singleton<_i873.OrdersRetrofitClient>(
      () => _i873.OrdersRetrofitClient(gh<_i361.Dio>()),
    );
    gh.factory<_i1064.AuthRetrofitClient>(
      () => _i1064.AuthRetrofitClient(gh<_i361.Dio>()),
    );
    gh.factory<_i293.StoreRemoteDataSource>(
      () => _i471.StoreRemoteDatasourceImpl(gh<_i873.OrdersRetrofitClient>()),
    );
    gh.factory<_i774.AuthRemoteDataSource>(
      () => _i173.AuthRemoteDataSourceImpl(gh<_i1064.AuthRetrofitClient>()),
    );
    gh.factory<_i1047.AuthRepo>(
      () => _i15.AuthRepoImpl(
        gh<_i774.AuthRemoteDataSource>(),
        gh<_i1063.AuthLocalDataSource>(),
        gh<_i28.ApiManager>(),
      ),
    );
    gh.factory<_i481.UserRemoteDataSource>(
      () => _i508.UserRemoteDatasourceImpl(gh<_i873.OrdersRetrofitClient>()),
    );
    gh.factory<_i1041.OrdersRemoteDataSource>(
      () => _i438.OrdersRemoteDatasourceImpl(gh<_i873.OrdersRetrofitClient>()),
    );
    gh.factory<_i931.OrderItemRemoteDataSource>(
      () =>
          _i726.OrderItemRemoteDatasourceImpl(gh<_i873.OrdersRetrofitClient>()),
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
