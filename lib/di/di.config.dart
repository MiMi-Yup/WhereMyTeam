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
import 'package:where_my_team/data/data_source/local/shared_preferences_service.dart'
    as _i14;
import 'package:where_my_team/data/data_source/remote/firebase_auth_service.dart'
    as _i4;
import 'package:where_my_team/data/data_source/remote/firestore_service.dart'
    as _i5;
import 'package:where_my_team/data/repo_impl/auth_repository_impl.dart' as _i20;
import 'package:where_my_team/data/repo_impl/gps_repository_impl.dart' as _i7;
import 'package:where_my_team/data/repo_impl/location_repository_impl.dart'
    as _i22;
import 'package:where_my_team/data/repo_impl/member_repository.dart' as _i30;
import 'package:where_my_team/data/repo_impl/preferences_repository_impl.dart'
    as _i24;
import 'package:where_my_team/data/repo_impl/role_repository_impl.dart' as _i10;
import 'package:where_my_team/data/repo_impl/route_repository_impl.dart'
    as _i12;
import 'package:where_my_team/data/repo_impl/shared_preferences_repository_impl.dart'
    as _i26;
import 'package:where_my_team/data/repo_impl/team_repository_impl.dart' as _i16;
import 'package:where_my_team/data/repo_impl/team_user_repository_impl.dart'
    as _i32;
import 'package:where_my_team/data/repo_impl/type_route_repository_impl.dart'
    as _i18;
import 'package:where_my_team/data/repo_impl/unit_of_work_impl.dart' as _i34;
import 'package:where_my_team/data/repo_impl/user_repository_impl.dart' as _i28;
import 'package:where_my_team/data/services/location_service.dart' as _i36;
import 'package:where_my_team/domain/repositories/auth_repository.dart' as _i19;
import 'package:where_my_team/domain/repositories/gps_repository.dart' as _i6;
import 'package:where_my_team/domain/repositories/location_repository.dart'
    as _i21;
import 'package:where_my_team/domain/repositories/member_repository.dart'
    as _i29;
import 'package:where_my_team/domain/repositories/preferences_repository.dart'
    as _i23;
import 'package:where_my_team/domain/repositories/role_repository.dart' as _i9;
import 'package:where_my_team/domain/repositories/route_repository.dart'
    as _i11;
import 'package:where_my_team/domain/repositories/shared_preferences_repository.dart'
    as _i25;
import 'package:where_my_team/domain/repositories/team_repository.dart' as _i15;
import 'package:where_my_team/domain/repositories/team_user_repository.dart'
    as _i31;
import 'package:where_my_team/domain/repositories/type_route_repository.dart'
    as _i17;
import 'package:where_my_team/domain/repositories/unit_of_work.dart' as _i33;
import 'package:where_my_team/domain/repositories/user_repository.dart' as _i27;
import 'package:where_my_team/domain/use_cases/login_page_usecases.dart'
    as _i37;
import 'package:where_my_team/domain/use_cases/map_usecases.dart' as _i38;
import 'package:where_my_team/domain/use_cases/route_usecases.dart' as _i39;
import 'package:where_my_team/domain/use_cases/team_usecases.dart' as _i40;
import 'package:where_my_team/models/model_route.dart' as _i44;
import 'package:where_my_team/models/model_team.dart' as _i46;
import 'package:where_my_team/models/model_user.dart' as _i50;
import 'package:where_my_team/presentation/auth/account_setup/cubit/account_setup_cubit.dart'
    as _i42;
import 'package:where_my_team/presentation/auth/login/cubit/login_cubit.dart'
    as _i47;
import 'package:where_my_team/presentation/bottom_bar/cubit/bottom_bar_cubit.dart'
    as _i35;
import 'package:where_my_team/presentation/detail_route/cubit/detail_route_cubit.dart'
    as _i43;
import 'package:where_my_team/presentation/detail_team/cubit/detail_team_cubit.dart'
    as _i45;
import 'package:where_my_team/presentation/map/cubit/map_cubit.dart' as _i53;
import 'package:where_my_team/presentation/map/cubit/team_map_cubit.dart'
    as _i52;
import 'package:where_my_team/presentation/new_team/cubit/new_team_cubit.dart'
    as _i48;
import 'package:where_my_team/presentation/route/cubit/route_cubit.dart'
    as _i49;
import 'package:where_my_team/presentation/team/cubit/team_cubit.dart' as _i51;
import 'package:where_my_team/presentation/welcome/cubit/welcome_cubit.dart'
    as _i41;

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
    gh.singleton<_i14.SharedPreferencesService>(
        _i14.SharedPreferencesService());
    gh.factory<_i15.TeamRepository>(
        () => _i16.TeamRepositoryImpl(firestore: gh<_i5.FirestoreService>()));
    gh.factory<_i17.TypeRouteRepository>(() => _i18.TypeRouteRepositoryImpl(
          firestore: gh<_i5.FirestoreService>(),
          authService: gh<_i4.FirebaseAuthService>(),
        ));
    gh.factory<_i19.AuthRepository>(() =>
        _i20.AuthRepositoryImpl(authService: gh<_i4.FirebaseAuthService>()));
    gh.factory<_i21.LocationRepository>(() => _i22.LocationRepositoryImpl(
          firestore: gh<_i5.FirestoreService>(),
          auth: gh<_i4.FirebaseAuthService>(),
          routeRepo: gh<_i11.RouteRepository>(),
        ));
    gh.factory<_i23.PreferencesRepository>(() => _i24.PreferencesRepositoryImpl(
        storage: gh<_i13.SecurePreferencesService>()));
    gh.factory<_i25.SharedPreferencesRepository>(() =>
        _i26.SharedPreferencesRepositoryImpl(
            storage: gh<_i14.SharedPreferencesService>()));
    gh.factory<_i27.UserRepository>(() => _i28.UserRepositoryImpl(
          firestore: gh<_i5.FirestoreService>(),
          auth: gh<_i4.FirebaseAuthService>(),
          locationRepo: gh<_i21.LocationRepository>(),
        ));
    gh.factory<_i29.MemberRepository>(() => _i30.MemberRepositoryImpl(
          firestore: gh<_i5.FirestoreService>(),
          userRepo: gh<_i27.UserRepository>(),
          roleRepo: gh<_i9.RoleRepository>(),
          teamRepo: gh<_i15.TeamRepository>(),
        ));
    gh.factory<_i31.TeamUserRepository>(() => _i32.TeamUserRepositoryImpl(
          firestore: gh<_i5.FirestoreService>(),
          authService: gh<_i4.FirebaseAuthService>(),
          userRepo: gh<_i27.UserRepository>(),
        ));
    gh.factory<_i33.UnitOfWork>(() => _i34.UnitOfWorkImpl(
          location: gh<_i21.LocationRepository>(),
          user: gh<_i27.UserRepository>(),
          gps: gh<_i6.GPSRepository>(),
          preferences: gh<_i23.PreferencesRepository>(),
          auth: gh<_i19.AuthRepository>(),
          role: gh<_i9.RoleRepository>(),
          team: gh<_i15.TeamRepository>(),
          teamUser: gh<_i31.TeamUserRepository>(),
          memberTeam: gh<_i29.MemberRepository>(),
          route: gh<_i11.RouteRepository>(),
          typeRoute: gh<_i17.TypeRouteRepository>(),
        ));
    gh.factory<_i35.BottomBarCubit>(
        () => _i35.BottomBarCubit(unitOfWork: gh<_i33.UnitOfWork>()));
    gh.lazySingleton<_i36.LocationServiceImpl>(
      () => _i36.LocationServiceImpl(unitOfWork: gh<_i33.UnitOfWork>()),
      dispose: (i) => i.dispose(),
    );
    gh.factory<_i37.LoginUseCases>(() => _i37.LoginUseCases(
          unitOfWork: gh<_i33.UnitOfWork>(),
          authService: gh<_i4.FirebaseAuthService>(),
        ));
    gh.factory<_i38.MapUsercase>(
        () => _i38.MapUsercase(unitOfWork: gh<_i33.UnitOfWork>()));
    gh.factory<_i39.RouteUsercase>(
        () => _i39.RouteUsercase(unitOfWork: gh<_i33.UnitOfWork>()));
    gh.factory<_i40.TeamUsercase>(
        () => _i40.TeamUsercase(unitOfWork: gh<_i33.UnitOfWork>()));
    gh.factory<_i41.WelcomeCubit>(() => _i41.WelcomeCubit(
          loginUseCases: gh<_i37.LoginUseCases>(),
          teamUsercase: gh<_i40.TeamUsercase>(),
        ));
    gh.factory<_i42.AccountSetupCubit>(() =>
        _i42.AccountSetupCubit(homepageUseCases: gh<_i40.TeamUsercase>()));
    gh.factory<_i43.DetailRouteCubit>(() => _i43.DetailRouteCubit(
          routeUsercase: gh<_i39.RouteUsercase>(),
          route: gh<_i44.ModelRoute>(),
        ));
    gh.factory<_i45.DetailTeamCubit>(() => _i45.DetailTeamCubit(
          teamUseCases: gh<_i40.TeamUsercase>(),
          team: gh<_i46.ModelTeam>(),
        ));
    gh.factory<_i47.LoginCubit>(
        () => _i47.LoginCubit(loginUserCases: gh<_i37.LoginUseCases>()));
    gh.factory<_i48.NewTeamCubit>(
        () => _i48.NewTeamCubit(teamUsercase: gh<_i40.TeamUsercase>()));
    gh.factory<_i49.RouteCubit>(() => _i49.RouteCubit(
          routeUsercase: gh<_i39.RouteUsercase>(),
          user: gh<_i50.ModelUser>(),
        ));
    gh.factory<_i51.TeamCubit>(
        () => _i51.TeamCubit(teamUsercase: gh<_i40.TeamUsercase>()));
    gh.factory<_i52.TeamMapCubit>(
        () => _i52.TeamMapCubit(homepageUseCases: gh<_i40.TeamUsercase>()));
    gh.factory<_i53.MapCubit>(() => _i53.MapCubit(
          mapUseCases: gh<_i38.MapUsercase>(),
          userCubit: gh<_i52.TeamMapCubit>(),
        ));
    return this;
  }
}
