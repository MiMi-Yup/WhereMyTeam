import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wmteam/domain/repositories/generic_repository.dart';
import 'package:wmteam/models/model_team.dart';
import 'package:wmteam/models/model_team_user.dart';
import 'package:wmteam/models/model_user.dart';

abstract class TeamUserRepository extends GenericRepository {
  Stream<QuerySnapshot<ModelTeamUser>> getStream();
  Future<Set<ModelUser>?> getFavourites({required String teamId});
  Future<List<ModelTeamUser>?> getTeams();

  Future<bool> addFavourite({required ModelTeam team, List<ModelUser>? users});
  Future<bool> removeFavourite(
      {required ModelTeam team, required ModelUser user});
  Future<bool> unFavourite({required ModelTeam team, required ModelUser user});
  Future<bool> deleteTeam({required ModelTeam team});
}
