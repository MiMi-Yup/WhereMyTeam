import 'package:injectable/injectable.dart';
import 'package:where_my_team/domain/repositories/auth_repository.dart';
import 'package:where_my_team/domain/repositories/gps_repository.dart';
import 'package:where_my_team/domain/repositories/location_repository.dart';
import 'package:where_my_team/domain/repositories/preferences_repository.dart';
import 'package:where_my_team/domain/repositories/unit_of_work.dart';
import 'package:where_my_team/domain/repositories/user_repository.dart';

@Injectable(as: UnitOfWork)
class UnitOfWorkImpl implements UnitOfWork {
  final LocationRepository locationRepo;
  final UserRepository userRepo;
  final GPSRepository gpsRepo;
  final PreferencesRepository preferencesRepo;
  final AuthRepository authRepo;

  @override
  LocationRepository get location => locationRepo;

  @override
  UserRepository get user => userRepo;

  @override
  GPSRepository get gps => gpsRepo;

  @override
  AuthRepository get auth => authRepo;

  @override
  PreferencesRepository get preferences => preferencesRepo;

  UnitOfWorkImpl(
      {required this.locationRepo,
      required this.userRepo,
      required this.gpsRepo,
      required this.preferencesRepo,
      required this.authRepo});
}
