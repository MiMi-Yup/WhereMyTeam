import 'package:wmteam/domain/repositories/generic_repository.dart';
import 'package:wmteam/models/model_member.dart';
import 'package:wmteam/models/model_role.dart';
import 'package:wmteam/models/model_team.dart';
import 'package:wmteam/models/model_user.dart';

abstract class MemberRepository extends GenericRepository {
  Future<ModelMember?> getMember(
      {required ModelTeam team, required ModelUser user});

  Future<bool> postMember(
      {required ModelTeam team,
      required ModelUser user,
      required ModelRole role,
      String? nickname});

  Future<bool> putRole({required ModelMember member, required ModelRole role});
  Future<bool> putNickname(
      {required ModelMember member, required String nickname});

  Future<bool> deleteMember({required ModelMember member});
}
