import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wmteam/di/di.dart';
import 'package:wmteam/domain/repositories/location_repository.dart';
import 'package:wmteam/domain/repositories/type_route_repository.dart';
import 'package:wmteam/models/model_location.dart';
import 'package:wmteam/models/model_type_route.dart';
import 'package:wmteam/utils/time_util.dart';
import 'model.dart';

class ModelRoute extends IModel {
  String? name;
  Timestamp? startTime;
  Timestamp? endTime;
  bool? isShared;
  DocumentReference? typeRoute;
  DocumentReference? user;
  late double distance;
  late double maxSpeed;

  ModelRoute(
      {required super.id,
      this.name,
      required this.startTime,
      this.endTime,
      this.isShared = false,
      this.typeRoute,
      this.user,
      this.distance = 0.0,
      this.maxSpeed = 0.0}) {
    if (name == null || name!.isEmpty) {
      name = 'Route ${startTime?.toShortDateTime}';
    }
  }

  ModelRoute.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options)
      : super.fromFirestore(snapshot, options) {
    Map<String, dynamic>? data = snapshot.data();
    name = data?['name'];
    startTime = data?['startTime'];
    endTime = data?['endTime'];
    isShared = data?['isShared'];
    typeRoute = data?['typeRoute'];
    user = data?['user'];
    final _distance = data?['distance'];
    final _maxSpeed = data?['maxSpeed'];
    distance = _distance != null
        ? _distance is double
            ? _distance
            : _distance * 1.0
        : 0.0;
    maxSpeed = _maxSpeed != null
        ? _maxSpeed is double
            ? _maxSpeed
            : _maxSpeed * 1.0
        : 0.0;
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'startTime': startTime,
      'endTime': endTime,
      'isShared': isShared,
      'distance': distance,
      'maxSpeed': maxSpeed,
      'typeRoute': typeRoute,
      'user': user,
    };
  }

  @override
  Map<String, dynamic> updateFirestore() => {
        'isShared': isShared,
        'endTime': endTime,
        'name': name,
        'distance': distance,
        'maxSpeed': maxSpeed,
      };

  ModelRoute copyWith(
          {String? id,
          String? name,
          Timestamp? endTime,
          bool? isShared,
          double? distance,
          double? maxSpeed}) =>
      ModelRoute(
          id: id ?? this.id,
          startTime: startTime,
          endTime: endTime ?? this.endTime,
          isShared: isShared ?? this.isShared,
          distance: distance ?? this.distance,
          maxSpeed: maxSpeed ?? this.maxSpeed,
          typeRoute: typeRoute,
          name: name ?? this.name);
}

extension ModelRouteExtension on ModelRoute {
  Future<List<ModelLocation>?> get detailRouteEx async =>
      id == null || user == null
          ? null
          : await getIt<LocationRepository>()
              .getDetailRoute(this);

  Future<ModelTypeRoute?> get typeRouteEx async =>
      id == null || typeRoute == null
          ? null
          : (await getIt<TypeRouteRepository>().getModelByRef(typeRoute!))
              as ModelTypeRoute;
}
