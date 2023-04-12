import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:where_my_team/di/di.dart';
import 'package:where_my_team/domain/repositories/role_repository.dart';
import 'package:where_my_team/domain/repositories/team_repository.dart';
import 'package:where_my_team/domain/repositories/user_repository.dart';
import 'package:where_my_team/models/model_role.dart';
import 'package:where_my_team/models/model_team.dart';
import 'package:where_my_team/models/model_user.dart';
import 'model.dart';

class ModelMember extends IModel {
  DocumentReference? role;
  DocumentReference? team;
  String? nickname;
  Timestamp? joinTime;

  ModelMember(
      {required super.id,
      required this.role,
      required this.joinTime,
      required this.team,
      this.nickname});

  ModelMember.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options)
      : super.fromFirestore(snapshot, options) {
    Map<String, dynamic>? data = snapshot.data();
    role = data?['role'];
    joinTime = data?['joinTime'];
    nickname = data?['nickname'];
    team = data?['team'];
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {'role': role, 'nickname': nickname};
  }

  @override
  Map<String, dynamic> updateFirestore() => toFirestore();

  ModelMember copyWith({DocumentReference? role, String? nickname}) =>
      ModelMember(
          id: id,
          nickname: nickname ?? this.nickname,
          role: role ?? this.role,
          joinTime: joinTime,
          team: team);
}

extension ModelMemberExtension on ModelMember {
  Future<ModelRole?> get roleEx async => role == null
      ? null
      : (await getIt<RoleRepository>().getModelByRef(role!)) as ModelRole?;

  Future<ModelTeam?> get teamEx async => team == null
      ? null
      : (await getIt<TeamRepository>().getModelByRef(team!)) as ModelTeam?;

  Future<ModelUser?> get userEx async =>
      id == null ? null : (await getIt<UserRepository>().getUser(userId: id!));
}
