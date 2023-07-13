// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i39;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:wmteam/data/data_source/local/battery_service.dart' as _i3;
import 'package:wmteam/data/data_source/local/gps_service.dart' as _i8;
import 'package:wmteam/data/data_source/local/secure_preferences_service.dart'
    as _i13;
import 'package:wmteam/data/data_source/local/shared_preferences_service.dart'
    as _i14;
import 'package:wmteam/data/data_source/remote/firebase_auth_service.dart'
    as _i4;
import 'package:wmteam/data/data_source/remote/firestore_service.dart' as _i5;
import 'package:wmteam/data/repo_impl/auth_repository_impl.dart' as _i20;
import 'package:wmteam/data/repo_impl/friend_request_repository_impl.dart'
    as _i30;
import 'package:wmteam/data/repo_impl/gps_repository_impl.dart' as _i7;
import 'package:wmteam/data/repo_impl/location_repository_impl.dart' as _i22;
import 'package:wmteam/data/repo_impl/member_repository.dart' as _i32;
import 'package:wmteam/data/repo_impl/preferences_repository_impl.dart' as _i24;
import 'package:wmteam/data/repo_impl/role_repository_impl.dart' as _i10;
import 'package:wmteam/data/repo_impl/route_repository_impl.dart' as _i12;
import 'package:wmteam/data/repo_impl/shared_preferences_repository_impl.dart'
    as _i26;
import 'package:wmteam/data/repo_impl/team_repository_impl.dart' as _i16;
import 'package:wmteam/data/repo_impl/team_user_repository_impl.dart' as _i34;
import 'package:wmteam/data/repo_impl/type_route_repository_impl.dart' as _i18;
import 'package:wmteam/data/repo_impl/unit_of_work_impl.dart' as _i36;
import 'package:wmteam/data/repo_impl/user_repository_impl.dart' as _i28;
import 'package:wmteam/data/services/battery_service.dart' as _i41;
import 'package:wmteam/data/services/location_service.dart' as _i45;
import 'package:wmteam/domain/repositories/auth_repository.dart' as _i19;
import 'package:wmteam/domain/repositories/friend_request_repository.dart'
    as _i29;
import 'package:wmteam/domain/repositories/gps_repository.dart' as _i6;
import 'package:wmteam/domain/repositories/location_repository.dart' as _i21;
import 'package:wmteam/domain/repositories/member_repository.dart' as _i31;
import 'package:wmteam/domain/repositories/preferences_repository.dart' as _i23;
import 'package:wmteam/domain/repositories/role_repository.dart' as _i9;
import 'package:wmteam/domain/repositories/route_repository.dart' as _i11;
import 'package:wmteam/domain/repositories/shared_preferences_repository.dart'
    as _i25;
import 'package:wmteam/domain/repositories/team_repository.dart' as _i15;
import 'package:wmteam/domain/repositories/team_user_repository.dart' as _i33;
import 'package:wmteam/domain/repositories/type_route_repository.dart' as _i17;
import 'package:wmteam/domain/repositories/unit_of_work.dart' as _i35;
import 'package:wmteam/domain/repositories/user_repository.dart' as _i27;
import 'package:wmteam/domain/use_cases/login_page_usecases.dart' as _i55;
import 'package:wmteam/domain/use_cases/map_usecases.dart' as _i46;
import 'package:wmteam/domain/use_cases/route_usecases.dart' as _i47;
import 'package:wmteam/domain/use_cases/team_usecases.dart' as _i48;
import 'package:wmteam/domain/use_cases/user_usecases.dart' as _i37;
import 'package:wmteam/models/model_route.dart' as _i53;
import 'package:wmteam/models/model_team.dart' as _i51;
import 'package:wmteam/models/model_user.dart' as _i40;
import 'package:wmteam/presentation/add_friend/cubit/add_friend_cubit.dart'
    as _i49;
import 'package:wmteam/presentation/add_member/cubit/add_member_cubit.dart'
    as _i50;
import 'package:wmteam/presentation/auth/account_setup/cubit/account_setup_cubit.dart'
    as _i38;
import 'package:wmteam/presentation/auth/login/cubit/login_cubit.dart' as _i62;
import 'package:wmteam/presentation/bottom_bar/cubit/bottom_bar_cubit.dart'
    as _i42;
import 'package:wmteam/presentation/detail_route/cubit/detail_route_cubit.dart'
    as _i52;
import 'package:wmteam/presentation/detail_team/cubit/detail_team_cubit.dart'
    as _i54;
import 'package:wmteam/presentation/friend_list/cubit/friend_list_cubit.dart'
    as _i43;
import 'package:wmteam/presentation/friend_request/cubit/friend_request_cubit.dart'
    as _i44;
import 'package:wmteam/presentation/map/cubit/map_cubit.dart' as _i63;
import 'package:wmteam/presentation/map/cubit/team_map_cubit.dart' as _i60;
import 'package:wmteam/presentation/new_team/cubit/new_team_cubit.dart' as _i56;
import 'package:wmteam/presentation/profile/cubit/profile_cubit.dart' as _i57;
import 'package:wmteam/presentation/route/cubit/route_cubit.dart' as _i58;
import 'package:wmteam/presentation/team/cubit/team_cubit.dart' as _i59;
import 'package:wmteam/presentation/welcome/cubit/welcome_cubit.dart' as _i61;

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
    gh.factory<_i15.TeamRepository>(() => _i16.TeamRepositoryImpl(
          firestore: gh<_i5.FirestoreService>(),
          roleRepo: gh<_i9.RoleRepository>(),
        ));
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
    gh.factory<_i29.FriendRequestRepository>(
        () => _i30.FriendRequestRepositoryImpl(
              firestore: gh<_i5.FirestoreService>(),
              auth: gh<_i4.FirebaseAuthService>(),
              userRepo: gh<_i27.UserRepository>(),
            ));
    gh.factory<_i31.MemberRepository>(() => _i32.MemberRepositoryImpl(
          firestore: gh<_i5.FirestoreService>(),
          userRepo: gh<_i27.UserRepository>(),
          roleRepo: gh<_i9.RoleRepository>(),
          teamRepo: gh<_i15.TeamRepository>(),
        ));
    gh.factory<_i33.TeamUserRepository>(() => _i34.TeamUserRepositoryImpl(
          firestore: gh<_i5.FirestoreService>(),
          authService: gh<_i4.FirebaseAuthService>(),
          userRepo: gh<_i27.UserRepository>(),
        ));
    gh.factory<_i35.UnitOfWork>(() => _i36.UnitOfWorkImpl(
          location: gh<_i21.LocationRepository>(),
          user: gh<_i27.UserRepository>(),
          gps: gh<_i6.GPSRepository>(),
          preferences: gh<_i23.PreferencesRepository>(),
          auth: gh<_i19.AuthRepository>(),
          role: gh<_i9.RoleRepository>(),
          team: gh<_i15.TeamRepository>(),
          teamUser: gh<_i33.TeamUserRepository>(),
          memberTeam: gh<_i31.MemberRepository>(),
          route: gh<_i11.RouteRepository>(),
          typeRoute: gh<_i17.TypeRouteRepository>(),
          sharedPref: gh<_i25.SharedPreferencesRepository>(),
          friends: gh<_i29.FriendRequestRepository>(),
        ));
    gh.factory<_i37.UserUseCases>(
        () => _i37.UserUseCases(unitOfWork: gh<_i35.UnitOfWork>()));
    gh.factory<_i38.AccountSetupCubit>(() => _i38.AccountSetupCubit(
          userAuth: gh<_i39.User>(),
          userModel: gh<_i40.ModelUser>(),
          usecase: gh<_i37.UserUseCases>(),
        ));
    gh.lazySingleton<_i41.BatteryServiceImpl>(
      () => _i41.BatteryServiceImpl(
        service: gh<_i3.BatteryService>(),
        unitOfWork: gh<_i35.UnitOfWork>(),
      ),
      dispose: (i) => i.dispose(),
    );
    gh.factory<_i42.BottomBarCubit>(
        () => _i42.BottomBarCubit(unitOfWork: gh<_i35.UnitOfWork>()));
    gh.factory<_i43.FriendListCubit>(
        () => _i43.FriendListCubit(usecase: gh<_i37.UserUseCases>()));
    gh.factory<_i44.FriendRequestCubit>(
        () => _i44.FriendRequestCubit(usecase: gh<_i37.UserUseCases>()));
    gh.lazySingleton<_i45.LocationServiceImpl>(
      () => _i45.LocationServiceImpl(unitOfWork: gh<_i35.UnitOfWork>()),
      dispose: (i) => i.dispose(),
    );
    gh.factory<_i46.MapUseCases>(
        () => _i46.MapUseCases(unitOfWork: gh<_i35.UnitOfWork>()));
    gh.factory<_i47.RouteUseCases>(
        () => _i47.RouteUseCases(unitOfWork: gh<_i35.UnitOfWork>()));
    gh.factory<_i48.TeamUseCases>(
        () => _i48.TeamUseCases(unitOfWork: gh<_i35.UnitOfWork>()));
    gh.factory<_i49.AddFriendCubit>(() => _i49.AddFriendCubit(
          usecase: gh<_i48.TeamUseCases>(),
          uow: gh<_i35.UnitOfWork>(),
        ));
    gh.factory<_i50.AddMemberCubit>(() => _i50.AddMemberCubit(
          usecase: gh<_i48.TeamUseCases>(),
          team: gh<_i51.ModelTeam>(),
        ));
    gh.factory<_i52.DetailRouteCubit>(() => _i52.DetailRouteCubit(
          usecase: gh<_i47.RouteUseCases>(),
          route: gh<_i53.ModelRoute>(),
        ));
    gh.factory<_i54.DetailTeamCubit>(() => _i54.DetailTeamCubit(
          usecase: gh<_i48.TeamUseCases>(),
          team: gh<_i51.ModelTeam>(),
        ));
    gh.factory<_i55.LoginUseCases>(() => _i55.LoginUseCases(
          unitOfWork: gh<_i35.UnitOfWork>(),
          authService: gh<_i4.FirebaseAuthService>(),
          teamUsercase: gh<_i48.TeamUseCases>(),
        ));
    gh.factory<_i56.NewTeamCubit>(() => _i56.NewTeamCubit(
          usecase: gh<_i48.TeamUseCases>(),
          userUseCases: gh<_i37.UserUseCases>(),
        ));
    gh.factory<_i57.ProfileCubit>(() => _i57.ProfileCubit(
          usecase: gh<_i48.TeamUseCases>(),
          userUseCases: gh<_i37.UserUseCases>(),
        ));
    gh.factory<_i58.RouteCubit>(() => _i58.RouteCubit(
          usecase: gh<_i47.RouteUseCases>(),
          user: gh<_i40.ModelUser>(),
        ));
    gh.factory<_i59.TeamCubit>(() => _i59.TeamCubit(
          usecase: gh<_i48.TeamUseCases>(),
          userUseCases: gh<_i37.UserUseCases>(),
        ));
    gh.factory<_i60.TeamMapCubit>(
        () => _i60.TeamMapCubit(usecase: gh<_i48.TeamUseCases>()));
    gh.factory<_i61.WelcomeCubit>(() => _i61.WelcomeCubit(
          loginUseCases: gh<_i55.LoginUseCases>(),
          teamUseCases: gh<_i48.TeamUseCases>(),
        ));
    gh.factory<_i62.LoginCubit>(
        () => _i62.LoginCubit(loginUserCases: gh<_i55.LoginUseCases>()));
    gh.factory<_i63.MapCubit>(() => _i63.MapCubit(
          usecase: gh<_i46.MapUseCases>(),
          userCubit: gh<_i60.TeamMapCubit>(),
        ));
    return this;
  }
}
