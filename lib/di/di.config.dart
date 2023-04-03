// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:where_my_team/data/auth/auth_repository_impl.dart' as _i5;
import 'package:where_my_team/data/data_source/local/gps_service.dart' as _i9;
import 'package:where_my_team/data/data_source/local/secure_preferences_service.dart'
    as _i12;
import 'package:where_my_team/data/data_source/remote/api_service.dart' as _i3;
import 'package:where_my_team/data/data_source/remote/auth_service.dart' as _i6;
import 'package:where_my_team/data/gps/gps_repository_impl.dart' as _i8;
import 'package:where_my_team/data/location/location_repository_impl.dart'
    as _i11;
import 'package:where_my_team/data/preferences_repository_impl.dart' as _i16;
import 'package:where_my_team/data/unit_of_work_impl.dart' as _i18;
import 'package:where_my_team/data/user/user_repository_impl.dart' as _i14;
import 'package:where_my_team/di/module/network_module.dart' as _i23;
import 'package:where_my_team/domain/repositories/auth_repository.dart' as _i4;
import 'package:where_my_team/domain/repositories/gps_repository.dart' as _i7;
import 'package:where_my_team/domain/repositories/location_repository.dart'
    as _i10;
import 'package:where_my_team/domain/repositories/preferences_repository.dart'
    as _i15;
import 'package:where_my_team/domain/repositories/unit_of_work.dart' as _i17;
import 'package:where_my_team/domain/repositories/user_repository.dart' as _i13;
import 'package:where_my_team/domain/use_cases/home_page_usecases.dart' as _i19;
import 'package:where_my_team/domain/use_cases/login_page_usecases.dart'
    as _i20;
import 'package:where_my_team/presentation/auth/login/cubit/login_page_cubit.dart'
    as _i22;
import 'package:where_my_team/presentation/home_page/cubit/home_page_cubit.dart'
    as _i21;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final networkModule = _$NetworkModule();
    gh.factory<_i3.ApiService>(() => networkModule.apiService);
    gh.factory<_i4.AuthRepository>(
        () => _i5.AuthRepositoryImpl(authService: gh<_i6.AuthService>()));
    gh.factory<_i6.AuthService>(() => networkModule.authService);
    gh.factory<_i7.GPSRepository>(
        () => _i8.GPSRepositoryImpl(gps: gh<_i9.GPSService>()));
    gh.singleton<_i9.GPSService>(_i9.GPSService());
    gh.factory<_i10.LocationRepository>(
        () => _i11.LocationRepositoryImpl(api: gh<_i3.ApiService>()));
    gh.singleton<_i12.SecurePreferencesService>(
        _i12.SecurePreferencesService());
    gh.factory<_i13.UserRepository>(
        () => _i14.UserRepositoryImpl(api: gh<_i3.ApiService>()));
    gh.factory<_i15.PreferencesRepository>(() => _i16.PreferencesRepositoryImpl(
        storage: gh<_i12.SecurePreferencesService>()));
    gh.factory<_i17.UnitOfWork>(() => _i18.UnitOfWorkImpl(
          locationRepo: gh<_i10.LocationRepository>(),
          userRepo: gh<_i13.UserRepository>(),
          gpsRepo: gh<_i7.GPSRepository>(),
          preferencesRepo: gh<_i15.PreferencesRepository>(),
          authRepo: gh<_i4.AuthRepository>(),
        ));
    gh.factory<_i19.HomepageUseCases>(
        () => _i19.HomepageUseCases(unitOfWork: gh<_i17.UnitOfWork>()));
    gh.factory<_i20.LoginUseCases>(
        () => _i20.LoginUseCases(unitOfWork: gh<_i17.UnitOfWork>()));
    gh.factory<_i21.HomePageCubit>(() =>
        _i21.HomePageCubit(homepageUseCases: gh<_i19.HomepageUseCases>()));
    gh.factory<_i22.LoginPageCubit>(
        () => _i22.LoginPageCubit(loginUserCases: gh<_i20.LoginUseCases>()));
    return this;
  }
}

class _$NetworkModule extends _i23.NetworkModule {}
