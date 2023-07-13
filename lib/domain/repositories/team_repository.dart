import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wmteam/domain/repositories/generic_repository.dart';
import 'package:wmteam/models/model_member.dart';
import 'package:wmteam/models/model_team.dart';

abstract class TeamRepository extends GenericRepository {
  Future<ModelTeam?> getTeam({required String teamId});
  Future<List<ModelMember>?> getMembers({required String teamId});
  Future<ModelMember?> adminOfTeam({required ModelTeam team});
  Stream<QuerySnapshot<ModelMember>> getStream({required ModelTeam team});
  Future<int> getNumberOfMembers({required String teamId});

  Future<bool> postTeam({required ModelTeam team});

  Future<bool> putAvatar({required ModelTeam team, required String path});
  Future<bool> putName({required ModelTeam team, required String name});

  Future<bool> deleteTeam({required ModelTeam team});
}
