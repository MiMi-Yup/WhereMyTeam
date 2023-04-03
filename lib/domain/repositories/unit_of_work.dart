import 'package:where_my_team/domain/repositories/auth_repository.dart';
import 'package:where_my_team/domain/repositories/gps_repository.dart';
import 'package:where_my_team/domain/repositories/location_repository.dart';
import 'package:where_my_team/domain/repositories/preferences_repository.dart';
import 'package:where_my_team/domain/repositories/user_repository.dart';

abstract class UnitOfWork{
  LocationRepository get location;
  UserRepository get user;
  GPSRepository get gps;
  AuthRepository get auth;
  PreferencesRepository get preferences;
}