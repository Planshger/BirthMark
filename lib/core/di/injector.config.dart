// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:birthmark/core/di/shared_module.dart' as _i339;
import 'package:birthmark/features/birthdate/data/models/birthdate_model.dart'
    as _i901;
import 'package:birthmark/features/birthdate/data/repositories/birthdate_repository_impl.dart'
    as _i225;
import 'package:birthmark/features/birthdate/domain/repositories/birthdate_repository.dart'
    as _i404;
import 'package:birthmark/features/birthdate/domain/usecases/add_birthdate.dart'
    as _i378;
import 'package:birthmark/features/birthdate/domain/usecases/delete_birthdate.dart'
    as _i66;
import 'package:birthmark/features/birthdate/domain/usecases/get_birthdates.dart'
    as _i638;
import 'package:birthmark/features/birthdate/domain/usecases/update_birthdate.dart'
    as _i1044;
import 'package:birthmark/features/birthdate/domain/usecases/watch_birthdates.dart'
    as _i658;
import 'package:birthmark/features/birthdate/presentation/bloc/birthdate_bloc.dart'
    as _i931;
import 'package:birthmark/features/onboarding/data/datasources/onboarding_local_data_source.dart'
    as _i209;
import 'package:birthmark/features/onboarding/data/repositories/onboarding_repository_impl.dart'
    as _i170;
import 'package:birthmark/features/onboarding/domain/repositories/onboarding_repository.dart'
    as _i295;
import 'package:birthmark/features/onboarding/domain/usecases/get_onboarding_items.dart'
    as _i393;
import 'package:birthmark/features/onboarding/domain/usecases/is_onboarding_completed.dart'
    as _i312;
import 'package:birthmark/features/onboarding/domain/usecases/mark_onboarding_completed.dart'
    as _i998;
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
    final sharedModule = _$SharedModule();
    await gh.lazySingletonAsync<bool>(
      () => sharedModule.initHive(),
      preResolve: true,
    );
    await gh.lazySingletonAsync<_i919.Box<_i901.BirthDateModel>>(
      () => sharedModule.provideBirthdatesBox(),
      preResolve: true,
    );
    await gh.lazySingletonAsync<_i460.SharedPreferences>(
      () => sharedModule.provideSharedPreferences(),
      preResolve: true,
    );
    gh.lazySingleton<_i209.OnboardingLocalDataSource>(
      () => _i209.OnboardingLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i404.BirthDateRepository>(
      () =>
          _i225.BirthdateRepositoryImpl(gh<_i919.Box<_i901.BirthDateModel>>()),
      dispose: (i) => i.dispose(),
    );
    gh.lazySingleton<_i295.OnboardingRepository>(
      () =>
          _i170.OnboardingRepositoryImpl(gh<_i209.OnboardingLocalDataSource>()),
    );
    gh.factory<_i378.AddBirthDate>(
      () => _i378.AddBirthDate(gh<_i404.BirthDateRepository>()),
    );
    gh.factory<_i66.DeleteBirthDate>(
      () => _i66.DeleteBirthDate(gh<_i404.BirthDateRepository>()),
    );
    gh.factory<_i638.GetBirthDates>(
      () => _i638.GetBirthDates(gh<_i404.BirthDateRepository>()),
    );
    gh.factory<_i1044.UpdateBirthDate>(
      () => _i1044.UpdateBirthDate(gh<_i404.BirthDateRepository>()),
    );
    gh.factory<_i658.WatchBirthDates>(
      () => _i658.WatchBirthDates(gh<_i404.BirthDateRepository>()),
    );
    gh.factory<_i931.BirthdateBloc>(
      () => _i931.BirthdateBloc(
        addBirthDate: gh<_i378.AddBirthDate>(),
        deleteBirthDate: gh<_i66.DeleteBirthDate>(),
        getBirthDates: gh<_i638.GetBirthDates>(),
        updateBirthDate: gh<_i1044.UpdateBirthDate>(),
      ),
    );
    gh.lazySingleton<_i393.GetOnboardingItems>(
      () => _i393.GetOnboardingItems(gh<_i295.OnboardingRepository>()),
    );
    gh.lazySingleton<_i312.IsOnboardingCompleted>(
      () => _i312.IsOnboardingCompleted(gh<_i295.OnboardingRepository>()),
    );
    gh.lazySingleton<_i998.MarkOnboardingCompleted>(
      () => _i998.MarkOnboardingCompleted(gh<_i295.OnboardingRepository>()),
    );
    return this;
  }
}

class _$SharedModule extends _i339.SharedModule {}
