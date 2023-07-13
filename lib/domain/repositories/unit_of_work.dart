import 'package:wmteam/domain/repositories/auth_repository.dart';
import 'package:wmteam/domain/repositories/friend_request_repository.dart';
import 'package:wmteam/domain/repositories/gps_repository.dart';
import 'package:wmteam/domain/repositories/location_repository.dart';
import 'package:wmteam/domain/repositories/member_repository.dart';
import 'package:wmteam/domain/repositories/preferences_repository.dart';
import 'package:wmteam/domain/repositories/role_repository.dart';
import 'package:wmteam/domain/repositories/route_repository.dart';
import 'package:wmteam/domain/repositories/shared_preferences_repository.dart';
import 'package:wmteam/domain/repositories/team_repository.dart';
import 'package:wmteam/domain/repositories/team_user_repository.dart';
import 'package:wmteam/domain/repositories/type_route_repository.dart';
import 'package:wmteam/domain/repositories/user_repository.dart';

abstract class UnitOfWork{
  LocationRepository get location;
  UserRepository get user;
  GPSRepository get gps;
  AuthRepository get auth;
  PreferencesRepository get preferences;
  RoleRepository get role;
  TeamRepository get team;
  TeamUserRepository get teamUser;
  MemberRepository get memberTeam;
  RouteRepository get route;
  TypeRouteRepository get typeRoute;
  SharedPreferencesRepository get sharedPref;
  FriendRequestRepository get friends;
}