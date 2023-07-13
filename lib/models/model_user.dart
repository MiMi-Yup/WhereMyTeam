import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wmteam/di/di.dart';
import 'package:wmteam/domain/repositories/location_repository.dart';
import 'package:wmteam/domain/repositories/route_repository.dart';
import 'package:wmteam/domain/repositories/team_user_repository.dart';
import 'package:wmteam/domain/repositories/user_repository.dart';
import 'package:wmteam/models/model_location.dart';
import 'package:wmteam/models/model_route.dart';
import 'package:wmteam/models/model_team_user.dart';
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
  List<DocumentReference>? friends;

  ModelUser(
      {required super.id,
      required this.email,
      this.name,
      this.phoneNumber,
      this.freezeLocation,
      this.shareNotification,
      this.avatar,
      this.lastLocation,
      this.percentBatteryDevice,
      this.friends});

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
    if (data?['friends'] != null &&
        data!['friends'] is List<dynamic>) {
      friends = (data['friends'] as List<dynamic>).cast<DocumentReference<Object?>>();
    }
  }

  @override
  Map<String, dynamic> toFirestore() => {
        'lastLocation': lastLocation,
        'email': email,
        'freezeLocation': freezeLocation,
        'name': name,
        'phoneNumber': phoneNumber,
        'shareNotification': shareNotification,
        'avatar': avatar,
        'percentBatteryDevice': percentBatteryDevice,
        'friends': friends
      };
  @override
  Map<String, dynamic> updateFirestore() => {
        'lastLocation': lastLocation,
        'freezeLocation': freezeLocation,
        'name': name,
        'phoneNumber': phoneNumber,
        'shareNotification': shareNotification,
        'avatar': avatar,
        'percentBatteryDevice': percentBatteryDevice,
        'friends': friends
      };

  @override
  bool operator ==(dynamic other) =>
      other != null && other is ModelUser && id == other.id;

  @override
  int get hashCode => super.hashCode;

  ModelUser copyWith(
          {String? id,
          DocumentReference? lastLocation,
          bool? freezeLocation,
          String? name,
          String? phoneNumber,
          bool? shareNotification,
          String? avatar,
          int? percentBatteryDevice,
          List<DocumentReference>? friends}) =>
      ModelUser(
          id: id ?? this.id,
          email: email,
          name: name ?? this.name,
          phoneNumber: phoneNumber ?? this.phoneNumber,
          freezeLocation: freezeLocation ?? this.freezeLocation,
          shareNotification: shareNotification ?? this.shareNotification,
          avatar: avatar ?? this.avatar,
          lastLocation: lastLocation ?? this.lastLocation,
          percentBatteryDevice:
              percentBatteryDevice ?? this.percentBatteryDevice,
          friends: friends ?? this.friends);
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

  Future<List<ModelUser>?> get getFriends =>
      getIt<UserRepository>().getFriend();
}
