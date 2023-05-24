import 'package:injectable/injectable.dart';
import 'package:where_my_team/domain/repositories/auth_repository.dart';
import 'package:where_my_team/domain/repositories/gps_repository.dart';
import 'package:where_my_team/domain/repositories/location_repository.dart';
import 'package:where_my_team/domain/repositories/member_repository.dart';
import 'package:where_my_team/domain/repositories/preferences_repository.dart';
import 'package:where_my_team/domain/repositories/role_repository.dart';
import 'package:where_my_team/domain/repositories/route_repository.dart';
import 'package:where_my_team/domain/repositories/team_user_repository.dart';
import 'package:where_my_team/domain/repositories/team_repository.dart';
import 'package:where_my_team/domain/repositories/type_route_repository.dart';
import 'package:where_my_team/domain/repositories/unit_of_work.dart';
import 'package:where_my_team/domain/repositories/user_repository.dart';

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
      required this.typeRoute});
}
