import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:where_my_team/di/di.dart';
import 'package:where_my_team/domain/repositories/route_repository.dart';
import 'package:where_my_team/domain/repositories/user_repository.dart';
import 'package:where_my_team/models/model_route.dart';
import 'package:where_my_team/models/model_user.dart';
import 'model.dart';

class ModelLocation extends IModel {
  DocumentReference? user;
  DocumentReference? route;
  Timestamp? timestamp;
  double? altitude;
  double? latitude;
  double? longitude;
  int? satelliteNumber;
  double? speed;

  ModelLocation(
      {required super.id,
      required this.user,
      required this.route,
      required this.timestamp,
      required this.altitude,
      required this.latitude,
      required this.longitude,
      required this.satelliteNumber,
      required this.speed});

  ModelLocation.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options)
      : super.fromFirestore(snapshot, options) {
    Map<String, dynamic>? data = snapshot.data();
    user = data?['user'];
    route = data?['route'];
    timestamp = data?['timestamp'];
    altitude = data?['altitude'];
    latitude = data?['latitude'];
    longitude = data?['longitude'];
    satelliteNumber = data?['satelliteNumber'];
    speed = data?['speed'];
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'user': user,
      'route': route,
      'timestamp': timestamp,
      'altitude': altitude,
      'latitude': latitude,
      'longitude': longitude,
      'satelliteNumber': satelliteNumber,
      'speed': speed,
    };
  }

  @override
  Map<String, dynamic> updateFirestore() {
    // TODO: implement updateFirestore
    throw UnimplementedError();
  }
}

extension ExtensionModelLocation on ModelLocation {
  Future<ModelUser?> get userM async => user == null
      ? null
      : await getIt<UserRepository>().getModelByRef(user!) as ModelUser;

  Future<ModelRoute?> get routeM async => route == null
      ? null
      : await getIt<RouteRepository>().getModelByRef(route!) as ModelRoute;

  LatLng get coordinate => LatLng(latitude ?? 0, longitude ?? 0);
}
