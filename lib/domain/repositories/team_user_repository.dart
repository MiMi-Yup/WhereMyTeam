import 'package:where_my_team/domain/repositories/generic_repository.dart';
import 'package:where_my_team/models/model_team_user.dart';
import 'package:where_my_team/models/model_user.dart';

abstract class TeamUserRepository extends GenericRepository {
  Future<Set<ModelUser>?> getFavourites({required String teamId});
  Future<List<ModelTeamUser>?> getTeams();

  Future<bool> addFavourite({required String teamId, required ModelUser user});
  Future<bool> removeFavourite(
      {required String teamId, required ModelUser user});
}
