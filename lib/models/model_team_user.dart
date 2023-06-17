import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:where_my_team/di/di.dart';
import 'package:where_my_team/domain/repositories/team_repository.dart';
import 'package:where_my_team/domain/repositories/team_user_repository.dart';
import 'package:where_my_team/models/model_team.dart';
import 'package:where_my_team/models/model_user.dart';
import 'model.dart';

class ModelTeamUser extends IModel {
  Set<DocumentReference>? favourite;

  ModelTeamUser({required super.id, this.favourite});

  ModelTeamUser.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options)
      : super.fromFirestore(snapshot, options) {
    Map<String, dynamic>? data = snapshot.data();
    favourite = data?['favourite'] == null
        ? null
        : Set<DocumentReference>.from(data?['favourite']);
    if (favourite != null && favourite!.isEmpty) favourite = null;
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'favourite': favourite,
    };
  }

  @override
  Map<String, dynamic> updateFirestore() => toFirestore();

  ModelTeamUser copyWith({Set<DocumentReference>? favourite}) =>
      ModelTeamUser(id: id, favourite: favourite ?? this.favourite);
}

extension ModelTeamUserExtension on ModelTeamUser {
  Future<Set<ModelUser>?> get favouritesEx async => id == null
      ? null
      : await getIt<TeamUserRepository>().getFavourites(teamId: id!);

  Future<ModelTeam?> get teamEx async =>
      id == null ? null : await getIt<TeamRepository>().getTeam(teamId: id!);
}
