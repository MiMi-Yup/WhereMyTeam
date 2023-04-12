import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:where_my_team/di/di.dart';
import 'package:where_my_team/domain/repositories/team_repository.dart';
import 'package:where_my_team/models/model_member.dart';
import 'model.dart';

class ModelTeam extends IModel {
  String? name;
  String? avatar;
  Timestamp? createdAt;

  ModelTeam(
      {required super.id,
      required this.name,
      required this.createdAt,
      this.avatar});

  ModelTeam.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options)
      : super.fromFirestore(snapshot, options) {
    Map<String, dynamic>? data = snapshot.data();
    name = data?['name'];
    createdAt = data?['createdAt'];
    avatar = data?['avatar'];
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {'name': name, 'createdAt': createdAt, 'avatar': avatar};
  }

  @override
  Map<String, dynamic> updateFirestore() => {'name': name, 'avatar': avatar};

  ModelTeam copyWith(
          {String? id, String? name, Timestamp? createdAt, String? avatar}) =>
      ModelTeam(
          id: id ?? this.id,
          name: name ?? this.name,
          createdAt: createdAt ?? this.createdAt,
          avatar: avatar ?? this.avatar);
}

extension ModelTeamExtension on ModelTeam {
  Future<List<ModelMember>?> get membersEx async =>
      id == null ? null : await getIt<TeamRepository>().getMembers(teamId: id!);
}