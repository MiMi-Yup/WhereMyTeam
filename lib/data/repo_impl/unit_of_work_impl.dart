import 'package:injectable/injectable.dart';
import 'package:wmteam/domain/repositories/auth_repository.dart';
import 'package:wmteam/domain/repositories/friend_request_repository.dart';
import 'package:wmteam/domain/repositories/gps_repository.dart';
import 'package:wmteam/domain/repositories/location_repository.dart';
import 'package:wmteam/domain/repositories/member_repository.dart';
import 'package:wmteam/domain/repositories/preferences_repository.dart';
import 'package:wmteam/domain/repositories/role_repository.dart';
import 'package:wmteam/domain/repositories/route_repository.dart';
import 'package:wmteam/domain/repositories/shared_preferences_repository.dart';
import 'package:wmteam/domain/repositories/team_user_repository.dart';
import 'package:wmteam/domain/repositories/team_repository.dart';
import 'package:wmteam/domain/repositories/type_route_repository.dart';
import 'package:wmteam/domain/repositories/unit_of_work.dart';
import 'package:wmteam/domain/repositories/user_repository.dart';

@Injectable(as: UnitOfWork)
class UnitOfWorkImpl implements UnitOfWork {
  @override
  final LocationRepository location;

  @override
  final UserRepository user;

  @override
  final GPSRepository gps;

  @override
  final PreferencesRepository preferences;

  @override
  final AuthRepository auth;

  @override
  final RoleRepository role;

  @override
  final MemberRepository memberTeam;

  @override
  final TeamRepository team;

  @override
  final TeamUserRepository teamUser;

  @override
  final RouteRepository route;

  @override
  final TypeRouteRepository typeRoute;

  @override
  final SharedPreferencesRepository sharedPref;

  @override
  final FriendRequestRepository friends;

  UnitOfWorkImpl(
      {required this.location,
      required this.user,
      required this.gps,
      required this.preferences,
      required this.auth,
      required this.role,
      required this.team,
      required this.teamUser,
      required this.memberTeam,
      required this.route,
      required this.typeRoute,
      required this.sharedPref,
      required this.friends});
}
