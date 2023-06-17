import 'package:where_my_team/models/model_route.dart';

abstract class LocationService {
  Future<void> updateLocation();
  void userLogout();
  ModelRoute? get currentRoute;
}
