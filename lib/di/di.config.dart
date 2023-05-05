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
import 'package:where_my_team/data/data_source/local/battery_service.dart'
    as _i3;
import 'package:where_my_team/data/data_source/local/gps_service.dart' as _i8;
import 'package:where_my_team/data/data_source/local/secure_preferences_service.dart'
    as _i13;
import 'package:where_my_team/data/data_source/remote/firebase_auth_service.dart'
    as _i4;
import 'package:where_my_team/data/data_source/remote/firestore_service.dart'
    as _i5;
import 'package:where_my_team/data/repo_impl/auth_repository_impl.dart' as _i17;
import 'package:where_my_team/data/repo_impl/gps_repository_impl.dart' as _i7;
import 'package:where_my_team/data/repo_impl/location_repository_impl.dart'
    as _i19;
import 'package:where_my_team/data/repo_impl/member_repository.dart' as _i25;
import 'package:where_my_team/data/repo_impl/preferences_repository_impl.dart'
    as _i21;
import 'package:where_my_team/data/repo_impl/role_repository_impl.dart' as _i10;
import 'package:where_my_team/data/repo_impl/route_repository_impl.dart'
    as _i12;
import 'package:where_my_team/data/repo_impl/team_repository_impl.dart' as _i15;
import 'package:where_my_team/data/repo_impl/team_user_repository_impl.dart'
    as _i27;
import 'package:where_my_team/data/repo_impl/unit_of_work_impl.dart' as _i29;
import 'package:where_my_team/data/repo_impl/user_repository_impl.dart' as _i23;
import 'package:where_my_team/data/services/location_service.dart' as _i30;
import 'package:where_my_team/domain/repositories/auth_repository.dart' as _i16;
import 'package:where_my_team/domain/repositories/gps_repository.dart' as _i6;
import 'package:where_my_team/domain/repositories/location_repository.dart'
    as _i18;
import 'package:where_my_team/domain/repositories/member_repository.dart'
    as _i24;
import 'package:where_my_team/domain/repositories/preferences_repository.dart'
    as _i20;
import 'package:where_my_team/domain/repositories/role_repository.dart' as _i9;
import 'package:where_my_team/domain/repositories/route_repository.dart'
    as _i11;
import 'package:where_my_team/domain/repositories/team_repository.dart' as _i14;
import 'package:where_my_team/domain/repositories/team_user_repository.dart'
    as _i26;
import 'package:where_my_team/domain/repositories/unit_of_work.dart' as _i28;
import 'package:where_my_team/domain/repositories/user_repository.dart' as _i22;
import 'package:where_my_team/domain/use_cases/login_page_usecases.dart'
    as _i31;
import 'package:where_my_team/domain/use_cases/team_usecases.dart' as _i32;
import 'package:where_my_team/presentation/auth/account_setup/cubit/account_setup_cubit.dart'
    as _i34;
import 'package:where_my_team/presentation/auth/login/cubit/login_cubit.dart'
    as _i37;
import 'package:where_my_team/presentation/detail_route/cubit/detail_route_cubit.dart'
    as _i35;
import 'package:where_my_team/presentation/detail_team/cubit/detail_team_cubit.dart'
    as _i36;
import 'package:where_my_team/presentation/map/cubit/map_cubit.dart' as _i42;
import 'package:where_my_team/presentation/map/cubit/team_map_cubit.dart'
    as _i41;
import 'package:where_my_team/presentation/new_team/cubit/new_team_cubit.dart'
    as _i38;
import 'package:where_my_team/presentation/route/cubit/route_cubit.dart'
    as _i39;
import 'package:where_my_team/presentation/team/cubit/team_cubit.dart' as _i40;
import 'package:where_my_team/presentation/welcome/cubit/welcome_cubit.dart'
    as _i33;

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
    gh.singleton<_i3.BatteryService>(_i3.BatteryService());
    gh.singleton<_i4.FirebaseAuthService>(_i4.FirebaseAuthService());
    gh.singleton<_i5.FirestoreService>(_i5.FirestoreService());
    gh.factory<_i6.GPSRepository>(
        () => _i7.GPSRepositoryImpl(gps: gh<_i8.GPSService>()));
    gh.singleton<_i8.GPSService>(_i8.GPSService());
    gh.factory<_i9.RoleRepository>(
        () => _i10.RoleRepositoryImpl(firestore: gh<_i5.FirestoreService>()));
    gh.factory<_i11.RouteRepository>(() => _i12.RouteRepositoryImpl(
          firestore: gh<_i5.FirestoreService>(),
          auth: gh<_i4.FirebaseAuthService>(),
        ));
    gh.singleton<_i13.SecurePreferencesService>(
        _i13.SecurePreferencesService());
    gh.factory<_i14.TeamRepository>(
        () => _i15.TeamRepositoryImpl(firestore: gh<_i5.FirestoreService>()));
    gh.factory<_i16.AuthRepository>(() =>
        _i17.AuthRepositoryImpl(authService: gh<_i4.FirebaseAuthService>()));
    gh.factory<_i18.LocationRepository>(() => _i19.LocationRepositoryImpl(
          firestore: gh<_i5.FirestoreService>(),
          auth: gh<_i4.FirebaseAuthService>(),
          routeRepo: gh<_i11.RouteRepository>(),
        ));
    gh.factory<_i20.PreferencesRepository>(() => _i21.PreferencesRepositoryImpl(
        storage: gh<_i13.SecurePreferencesService>()));
    gh.factory<_i22.UserRepository>(() => _i23.UserRepositoryImpl(
          firestore: gh<_i5.FirestoreService>(),
          auth: gh<_i4.FirebaseAuthService>(),
          locationRepo: gh<_i18.LocationRepository>(),
        ));
    gh.factory<_i24.MemberRepository>(() => _i25.MemberRepositoryImpl(
          firestore: gh<_i5.FirestoreService>(),
          userRepo: gh<_i22.UserRepository>(),
          roleRepo: gh<_i9.RoleRepository>(),
          teamRepo: gh<_i14.TeamRepository>(),
        ));
    gh.factory<_i26.TeamUserRepository>(() => _i27.TeamUserRepositoryImpl(
          firestore: gh<_i5.FirestoreService>(),
          authService: gh<_i4.FirebaseAuthService>(),
          userRepo: gh<_i22.UserRepository>(),
        ));
    gh.factory<_i28.UnitOfWork>(() => _i29.UnitOfWorkImpl(
          location: gh<_i18.LocationRepository>(),
          user: gh<_i22.UserRepository>(),
          gps: gh<_i6.GPSRepository>(),
          preferences: gh<_i20.PreferencesRepository>(),
          auth: gh<_i16.AuthRepository>(),
          role: gh<_i9.RoleRepository>(),
          team: gh<_i14.TeamRepository>(),
          teamUser: gh<_i26.TeamUserRepository>(),
          memberTeam: gh<_i24.MemberRepository>(),
        ));
    gh.singleton<_i30.LocationServiceImpl>(
        _i30.LocationServiceImpl(unitOfWork: gh<_i28.UnitOfWork>()));
    gh.factory<_i31.LoginUseCases>(() => _i31.LoginUseCases(
          unitOfWork: gh<_i28.UnitOfWork>(),
          authService: gh<_i4.FirebaseAuthService>(),
        ));
    gh.factory<_i32.TeamUsercase>(
        () => _i32.TeamUsercase(unitOfWork: gh<_i28.UnitOfWork>()));
    gh.factory<_i33.WelcomeCubit>(
        () => _i33.WelcomeCubit(loginUseCases: gh<_i31.LoginUseCases>()));
    gh.factory<_i34.AccountSetupCubit>(() =>
        _i34.AccountSetupCubit(homepageUseCases: gh<_i32.TeamUsercase>()));
    gh.factory<_i35.DetailRouteCubit>(
        () => _i35.DetailRouteCubit(homepageUseCases: gh<_i32.TeamUsercase>()));
    gh.factory<_i36.DetailTeamCubit>(
        () => _i36.DetailTeamCubit(homepageUseCases: gh<_i32.TeamUsercase>()));
    gh.factory<_i37.LoginCubit>(
        () => _i37.LoginCubit(loginUserCases: gh<_i31.LoginUseCases>()));
    gh.factory<_i38.NewTeamCubit>(
        () => _i38.NewTeamCubit(teamUsercase: gh<_i32.TeamUsercase>()));
    gh.factory<_i39.RouteCubit>(
        () => _i39.RouteCubit(homepageUseCases: gh<_i32.TeamUsercase>()));
    gh.factory<_i40.TeamCubit>(
        () => _i40.TeamCubit(teamUsercase: gh<_i32.TeamUsercase>()));
    gh.factory<_i41.TeamMapCubit>(
        () => _i41.TeamMapCubit(homepageUseCases: gh<_i32.TeamUsercase>()));
    gh.factory<_i42.MapCubit>(() => _i42.MapCubit(
          homepageUseCases: gh<_i32.TeamUsercase>(),
          userCubit: gh<_i41.TeamMapCubit>(),
        ));
    return this;
  }
}
