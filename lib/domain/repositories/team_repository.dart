import 'package:where_my_team/domain/repositories/generic_repository.dart';
import 'package:where_my_team/models/model_member.dart';
import 'package:where_my_team/models/model_team.dart';

abstract class TeamRepository extends GenericRepository {
  Future<ModelTeam?> getTeam({required String teamId});
  Future<List<ModelMember>?> getMembers({required String teamId});

  Future<bool> postTeam({required ModelTeam team});

  Future<bool> putAvatar({required ModelTeam team, required String path});
  Future<bool> putName({required ModelTeam team, required String name});

  Future<bool> deleteTeam({required ModelTeam team});
}
