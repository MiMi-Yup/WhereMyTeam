import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wmteam/di/di.dart';
import 'package:wmteam/domain/repositories/team_repository.dart';
import 'package:wmteam/models/model_member.dart';
import 'model.dart';

class ModelTeam extends IModel {
  String? name;
  String? avatar;
  Timestamp? createdAt;
  bool? isFamilyTeam;

  ModelTeam(
      {required super.id,
      required this.name,
      required this.createdAt,
      this.avatar,
      this.isFamilyTeam});

  ModelTeam.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options)
      : super.fromFirestore(snapshot, options) {
    Map<String, dynamic>? data = snapshot.data();
    name = data?['name'];
    createdAt = data?['createdAt'];
    avatar = data?['avatar'];
    isFamilyTeam = data?['isFamilyTeam'];
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'createdAt': createdAt,
      'avatar': avatar,
      'isFamilyTeam': isFamilyTeam
    };
  }

  @override
  Map<String, dynamic> updateFirestore() => {'name': name, 'avatar': avatar};

  ModelTeam copyWith(
          {String? id,
          String? name,
          Timestamp? createdAt,
          String? avatar,
          bool? isFamilyTeam}) =>
      ModelTeam(
          id: id ?? this.id,
          name: name ?? this.name,
          createdAt: createdAt ?? this.createdAt,
          avatar: avatar ?? this.avatar,
          isFamilyTeam: isFamilyTeam ?? this.isFamilyTeam);
}

extension ModelTeamExtension on ModelTeam {
  Future<List<ModelMember>?> get membersEx async =>
      id == null ? null : await getIt<TeamRepository>().getMembers(teamId: id!);
  Future<int> get getNumberOfMembers async => id == null
      ? 0
      : await getIt<TeamRepository>().getNumberOfMembers(teamId: id!);
}
