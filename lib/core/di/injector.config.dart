// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:birthmark/core/di/shared_module.dart' as _i339;
import 'package:birthmark/core/network/api_client.dart' as _i782;
import 'package:birthmark/features/auth/data/repositories/auth_repository_impl.dart'
    as _i767;
import 'package:birthmark/features/auth/domain/repositories/auth_repository.dart'
    as _i337;
import 'package:birthmark/features/auth/domain/usecases/login.dart' as _i754;
import 'package:birthmark/features/auth/domain/usecases/register.dart' as _i722;
import 'package:birthmark/features/auth/presentation/bloc/auth_bloc.dart'
    as _i854;
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive_ce_flutter/hive_flutter.dart' as _i919;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final injectionModule = _$InjectionModule();
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => injectionModule.secureStorage,
    );
    gh.lazySingleton<_i361.Dio>(() => injectionModule.dio);
    await gh.lazySingletonAsync<_i919.Box<dynamic>>(
      () => injectionModule.occasionBox,
      instanceName: 'occasionBox',
      preResolve: true,
    );
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => injectionModule.sharedPrefs,
      instanceName: 'prefs',
      preResolve: true,
    );
    await gh.lazySingletonAsync<_i919.Box<dynamic>>(
      () => injectionModule.categoryBox,
      instanceName: 'categoryBox',
      preResolve: true,
    );
    await gh.lazySingletonAsync<_i919.Box<dynamic>>(
      () => injectionModule.wishBox,
      instanceName: 'wishBox',
      preResolve: true,
    );
    gh.factory<String>(() => injectionModule.baseUrl, instanceName: 'baseUrl');
    gh.singleton<_i782.ApiClient>(
      () => _i782.ApiClient(
        gh<String>(instanceName: 'baseUrl'),
        gh<_i558.FlutterSecureStorage>(),
        gh<_i361.Dio>(),
      ),
    );
    gh.lazySingleton<_i337.AuthRepository>(
      () => _i767.AuthRepositoryImpl(
        gh<_i782.ApiClient>(),
        gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.factory<_i754.Login>(() => _i754.Login(gh<_i337.AuthRepository>()));
    gh.factory<_i722.Register>(
      () => _i722.Register(gh<_i337.AuthRepository>()),
    );
    gh.factory<_i854.AuthBloc>(
      () => _i854.AuthBloc(
        gh<_i754.Login>(),
        gh<_i722.Register>(),
        gh<_i337.AuthRepository>(),
      ),
    );
    return this;
  }
}

class _$InjectionModule extends _i339.InjectionModule {}
