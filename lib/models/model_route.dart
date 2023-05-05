import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:where_my_team/di/di.dart';
import 'package:where_my_team/domain/repositories/location_repository.dart';
import 'package:where_my_team/models/model_location.dart';
import 'model.dart';

class ModelRoute extends IModel {
  String? name;
  Timestamp? startTime;
  Timestamp? endTime;
  bool? isShared;

  ModelRoute(
      {required super.id,
      this.name,
      required this.startTime,
      required this.endTime,
      this.isShared = false}) {
    if (name == null || name!.isEmpty) {
      name = 'Route ${startTime.toString()}';
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
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'startTime': startTime,
      'endTime': endTime,
      'isShared': isShared
    };
  }

  @override
  Map<String, dynamic> updateFirestore() =>
      {'isShared': isShared, 'endTime': endTime, 'name': name};

  ModelRoute copyWith(
          {String? id,
          Timestamp? startTime,
          Timestamp? endTime,
          bool? isShared}) =>
      ModelRoute(
          id: id ?? this.id,
          startTime: startTime ?? this.startTime,
          endTime: endTime ?? this.endTime,
          isShared: isShared ?? this.isShared);
}

extension ModelRouteExtension on ModelRoute {
  Future<List<ModelLocation>?> get detailRouteEx async => id == null
      ? null
      : await getIt<LocationRepository>().getDetailRoute(id: id!);
}
