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
    as _i4;
import 'package:where_my_team/data/data_source/local/gps_service.dart' as _i9;
import 'package:where_my_team/data/data_source/local/secure_preferences_service.dart'
    as _i14;
import 'package:where_my_team/data/data_source/local/shared_preferences_service.dart'
    as _i15;
import 'package:where_my_team/data/data_source/remote/firebase_auth_service.dart'
    as _i5;
import 'package:where_my_team/data/data_source/remote/firestore_service.dart'
    as _i6;
import 'package:where_my_team/data/repo_impl/auth_repository_impl.dart' as _i21;
import 'package:where_my_team/data/repo_impl/gps_repository_impl.dart' as _i8;
import 'package:where_my_team/data/repo_impl/location_repository_impl.dart'
    as _i23;
import 'package:where_my_team/data/repo_impl/member_repository.dart' as _i31;
import 'package:where_my_team/data/repo_impl/preferences_repository_impl.dart'
    as _i25;
import 'package:where_my_team/data/repo_impl/role_repository_impl.dart' as _i11;
import 'package:where_my_team/data/repo_impl/route_repository_impl.dart'
    as _i13;
import 'package:where_my_team/data/repo_impl/shared_preferences_repository_impl.dart'
    as _i27;
import 'package:where_my_team/data/repo_impl/team_repository_impl.dart' as _i17;
import 'package:where_my_team/data/repo_impl/team_user_repository_impl.dart'
    as _i33;
import 'package:where_my_team/data/repo_impl/type_route_repository_impl.dart'
    as _i19;
import 'package:where_my_team/data/repo_impl/unit_of_work_impl.dart' as _i35;
import 'package:where_my_team/data/repo_impl/user_repository_impl.dart' as _i29;
import 'package:where_my_team/data/services/battery_service.dart' as _i36;
import 'package:where_my_team/data/services/location_service.dart' as _i38;
import 'package:where_my_team/domain/repositories/auth_repository.dart' as _i20;
import 'package:where_my_team/domain/repositories/gps_repository.dart' as _i7;
import 'package:where_my_team/domain/repositories/location_repository.dart'
    as _i22;
import 'package:where_my_team/domain/repositories/member_repository.dart'
    as _i30;
import 'package:where_my_team/domain/repositories/preferences_repository.dart'
    as _i24;
import 'package:where_my_team/domain/repositories/role_repository.dart' as _i10;
import 'package:where_my_team/domain/repositories/route_repository.dart'
    as _i12;
import 'package:where_my_team/domain/repositories/shared_preferences_repository.dart'
    as _i26;
import 'package:where_my_team/domain/repositories/team_repository.dart' as _i16;
import 'package:where_my_team/domain/repositories/team_user_repository.dart'
    as _i32;
import 'package:where_my_team/domain/repositories/type_route_repository.dart'
    as _i18;
import 'package:where_my_team/domain/repositories/unit_of_work.dart' as _i34;
import 'package:where_my_team/domain/repositories/user_repository.dart' as _i28;
import 'package:where_my_team/domain/use_cases/login_page_usecases.dart'
    as _i46;
import 'package:where_my_team/domain/use_cases/map_usecases.dart' as _i39;
import 'package:where_my_team/domain/use_cases/route_usecases.dart' as _i40;
import 'package:where_my_team/domain/use_cases/team_usecases.dart' as _i41;
import 'package:where_my_team/models/model_route.dart' as _i43;
import 'package:where_my_team/models/model_team.dart' as _i45;
import 'package:where_my_team/models/model_user.dart' as _i49;
import 'package:where_my_team/presentation/auth/account_setup/cubit/account_setup_cubit.dart'
    as _i3;
import 'package:where_my_team/presentation/auth/login/cubit/login_cubit.dart'
    as _i53;
import 'package:where_my_team/presentation/bottom_bar/cubit/bottom_bar_cubit.dart'
    as _i37;
import 'package:where_my_team/presentation/detail_route/cubit/detail_route_cubit.dart'
    as _i42;
import 'package:where_my_team/presentation/detail_team/cubit/detail_team_cubit.dart'
    as _i44;
import 'package:where_my_team/presentation/map/cubit/map_cubit.dart' as _i54;
import 'package:where_my_team/presentation/map/cubit/team_map_cubit.dart'
    as _i51;
import 'package:where_my_team/presentation/new_team/cubit/new_team_cubit.dart'
    as _i47;
import 'package:where_my_team/presentation/route/cubit/route_cubit.dart'
    as _i48;
import 'package:where_my_team/presentation/team/cubit/team_cubit.dart' as _i50;
import 'package:where_my_team/presentation/welcome/cubit/welcome_cubit.dart'
    as _i52;

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
    gh.factory<_i3.AccountSetupCubit>(() => _i3.AccountSetupCubit());
    gh.singleton<_i4.BatteryService>(_i4.BatteryService());
    gh.singleton<_i5.FirebaseAuthService>(_i5.FirebaseAuthService());
    gh.singleton<_i6.FirestoreService>(_i6.FirestoreService());
    gh.factory<_i7.GPSRepository>(
        () => _i8.GPSRepositoryImpl(gps: gh<_i9.GPSService>()));
    gh.singleton<_i9.GPSService>(_i9.GPSService());
    gh.factory<_i10.RoleRepository>(
        () => _i11.RoleRepositoryImpl(firestore: gh<_i6.FirestoreService>()));
    gh.factory<_i12.RouteRepository>(() => _i13.RouteRepositoryImpl(
          firestore: gh<_i6.FirestoreService>(),
          auth: gh<_i5.FirebaseAuthService>(),
        ));
    gh.singleton<_i14.SecurePreferencesService>(
        _i14.SecurePreferencesService());
    gh.singleton<_i15.SharedPreferencesService>(
        _i15.SharedPreferencesService());
    gh.factory<_i16.TeamRepository>(
        () => _i17.TeamRepositoryImpl(firestore: gh<_i6.FirestoreService>()));
    gh.factory<_i18.TypeRouteRepository>(() => _i19.TypeRouteRepositoryImpl(
          firestore: gh<_i6.FirestoreService>(),
          authService: gh<_i5.FirebaseAuthService>(),
        ));
    gh.factory<_i20.AuthRepository>(() =>
        _i21.AuthRepositoryImpl(authService: gh<_i5.FirebaseAuthService>()));
    gh.factory<_i22.LocationRepository>(() => _i23.LocationRepositoryImpl(
          firestore: gh<_i6.FirestoreService>(),
          auth: gh<_i5.FirebaseAuthService>(),
          routeRepo: gh<_i12.RouteRepository>(),
        ));
    gh.factory<_i24.PreferencesRepository>(() => _i25.PreferencesRepositoryImpl(
        storage: gh<_i14.SecurePreferencesService>()));
    gh.factory<_i26.SharedPreferencesRepository>(() =>
        _i27.SharedPreferencesRepositoryImpl(
            storage: gh<_i15.SharedPreferencesService>()));
    gh.factory<_i28.UserRepository>(() => _i29.UserRepositoryImpl(
          firestore: gh<_i6.FirestoreService>(),
          auth: gh<_i5.FirebaseAuthService>(),
          locationRepo: gh<_i22.LocationRepository>(),
        ));
    gh.factory<_i30.MemberRepository>(() => _i31.MemberRepositoryImpl(
          firestore: gh<_i6.FirestoreService>(),
          userRepo: gh<_i28.UserRepository>(),
          roleRepo: gh<_i10.RoleRepository>(),
          teamRepo: gh<_i16.TeamRepository>(),
        ));
    gh.factory<_i32.TeamUserRepository>(() => _i33.TeamUserRepositoryImpl(
          firestore: gh<_i6.FirestoreService>(),
          authService: gh<_i5.FirebaseAuthService>(),
          userRepo: gh<_i28.UserRepository>(),
        ));
    gh.factory<_i34.UnitOfWork>(() => _i35.UnitOfWorkImpl(
          location: gh<_i22.LocationRepository>(),
          user: gh<_i28.UserRepository>(),
          gps: gh<_i7.GPSRepository>(),
          preferences: gh<_i24.PreferencesRepository>(),
          auth: gh<_i20.AuthRepository>(),
          role: gh<_i10.RoleRepository>(),
          team: gh<_i16.TeamRepository>(),
          teamUser: gh<_i32.TeamUserRepository>(),
          memberTeam: gh<_i30.MemberRepository>(),
          route: gh<_i12.RouteRepository>(),
          typeRoute: gh<_i18.TypeRouteRepository>(),
        ));
    gh.lazySingleton<_i36.BatteryServiceImpl>(
      () => _i36.BatteryServiceImpl(
        service: gh<_i4.BatteryService>(),
        unitOfWork: gh<_i34.UnitOfWork>(),
      ),
      dispose: (i) => i.dispose(),
    );
    gh.factory<_i37.BottomBarCubit>(
        () => _i37.BottomBarCubit(unitOfWork: gh<_i34.UnitOfWork>()));
    gh.lazySingleton<_i38.LocationServiceImpl>(
      () => _i38.LocationServiceImpl(unitOfWork: gh<_i34.UnitOfWork>()),
      dispose: (i) => i.dispose(),
    );
    gh.factory<_i39.MapUsercase>(
        () => _i39.MapUsercase(unitOfWork: gh<_i34.UnitOfWork>()));
    gh.factory<_i40.RouteUsercase>(
        () => _i40.RouteUsercase(unitOfWork: gh<_i34.UnitOfWork>()));
    gh.factory<_i41.TeamUsercase>(
        () => _i41.TeamUsercase(unitOfWork: gh<_i34.UnitOfWork>()));
    gh.factory<_i42.DetailRouteCubit>(() => _i42.DetailRouteCubit(
          routeUsercase: gh<_i40.RouteUsercase>(),
          route: gh<_i43.ModelRoute>(),
        ));
    gh.factory<_i44.DetailTeamCubit>(() => _i44.DetailTeamCubit(
          teamUseCases: gh<_i41.TeamUsercase>(),
          team: gh<_i45.ModelTeam>(),
        ));
    gh.factory<_i46.LoginUseCases>(() => _i46.LoginUseCases(
          unitOfWork: gh<_i34.UnitOfWork>(),
          authService: gh<_i5.FirebaseAuthService>(),
          teamUsercase: gh<_i41.TeamUsercase>(),
        ));
    gh.factory<_i47.NewTeamCubit>(
        () => _i47.NewTeamCubit(teamUsercase: gh<_i41.TeamUsercase>()));
    gh.factory<_i48.RouteCubit>(() => _i48.RouteCubit(
          routeUsercase: gh<_i40.RouteUsercase>(),
          user: gh<_i49.ModelUser>(),
        ));
    gh.factory<_i50.TeamCubit>(
        () => _i50.TeamCubit(teamUsercase: gh<_i41.TeamUsercase>()));
    gh.factory<_i51.TeamMapCubit>(
        () => _i51.TeamMapCubit(homepageUseCases: gh<_i41.TeamUsercase>()));
    gh.factory<_i52.WelcomeCubit>(() => _i52.WelcomeCubit(
          loginUseCases: gh<_i46.LoginUseCases>(),
          teamUsercase: gh<_i41.TeamUsercase>(),
        ));
    gh.factory<_i53.LoginCubit>(
        () => _i53.LoginCubit(loginUserCases: gh<_i46.LoginUseCases>()));
    gh.factory<_i54.MapCubit>(() => _i54.MapCubit(
          mapUseCases: gh<_i39.MapUsercase>(),
          userCubit: gh<_i51.TeamMapCubit>(),
        ));
    return this;
  }
}
