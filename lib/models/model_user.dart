import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:where_my_team/di/di.dart';
import 'package:where_my_team/domain/repositories/location_repository.dart';
import 'package:where_my_team/domain/repositories/route_repository.dart';
import 'package:where_my_team/domain/repositories/team_user_repository.dart';
import 'package:where_my_team/models/model_location.dart';
import 'package:where_my_team/models/model_route.dart';
import 'package:where_my_team/models/model_team_user.dart';
import 'model.dart';

class ModelUser extends IModel {
  DocumentReference? lastLocation;
  String? email;
  bool? freezeLocation;
  String? name;
  String? phoneNumber;
  bool? shareNotification;
  String? avatar;
  int? percentBatteryDevice;

  ModelUser(
      {required super.id,
      required this.email,
      this.name,
      this.phoneNumber,
      this.freezeLocation,
      this.shareNotification,
      this.avatar,
      this.lastLocation,
      this.percentBatteryDevice});

  ModelUser.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options)
      : super.fromFirestore(snapshot, options) {
    Map<String, dynamic>? data = snapshot.data();
    lastLocation = data?['lastLocation'];
    email = data?['email'];
    freezeLocation = data?['freezeLocation'];
    name = data?['name'];
    phoneNumber = data?['phoneNumber'];
    shareNotification = data?['shareNotification'];
    avatar = data?['avatar'];
    percentBatteryDevice = data?['percentBatteryDevice'];
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'lastLocation': lastLocation,
      'email': email,
      'freezeLocation': freezeLocation,
      'name': name,
      'phoneNumber': phoneNumber,
      'shareNotification': shareNotification,
      'avatar': avatar,
      'percentBatteryDevice': percentBatteryDevice
    };
  }

  @override
  Map<String, dynamic> updateFirestore() => toFirestore();

  @override
  bool operator ==(dynamic other) =>
      other != null && other is ModelUser && id == other.id;

  @override
  int get hashCode => super.hashCode;

  ModelUser copyWith(
          {String? id,
          DocumentReference? lastLocation,
          String? email,
          bool? freezeLocation,
          String? name,
          String? phoneNumber,
          bool? shareNotification,
          String? avatar,
          int? percentBatteryDevice}) =>
      ModelUser(
          id: id ?? this.id,
          email: email ?? this.email,
          name: name ?? this.name,
          phoneNumber: phoneNumber ?? this.phoneNumber,
          freezeLocation: freezeLocation ?? this.freezeLocation,
          shareNotification: shareNotification ?? this.shareNotification,
          avatar: avatar ?? this.avatar,
          lastLocation: lastLocation ?? this.lastLocation,
          percentBatteryDevice:
              percentBatteryDevice ?? this.percentBatteryDevice);
}

extension ModelUserExtension on ModelUser {
  Future<ModelLocation?> get lastLocationEx async => lastLocation == null
      ? null
      : (await getIt<LocationRepository>().getModelByRef(lastLocation!))
          as ModelLocation?;

  Future<List<ModelTeamUser>?> get teamsEx =>
      getIt<TeamUserRepository>().getTeams();

  Future<List<ModelRoute>?> get routesEx =>
      getIt<RouteRepository>().getRoutes(id: id);
}
