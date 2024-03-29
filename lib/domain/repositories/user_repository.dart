import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wmteam/models/model_location.dart';
import 'package:wmteam/models/model_team_user.dart';
import 'package:wmteam/models/model_user.dart';

import 'generic_repository.dart';

abstract class UserRepository extends GenericRepository {
  Future<ModelUser?> getCurrentUser();
  Future<ModelUser?> getUser({required String userId});
  Future<List<ModelUser>?> getUsers();
  Future<ModelTeamUser?> getFamilyTeam();
  Stream<DocumentSnapshot<ModelUser>> snapshot({required String userId});

  Future<void> postUserInitial();

  Future<bool> putLastLocation({required ModelLocation lastLocation});
  Future<bool> putFreezeLocation({required bool state});
  Future<bool> putShareNotification({required bool state});
  Future<bool> putBattery({required int level});
  Future<bool> putAvatar({required String path});
  Future<bool> putUserInitial(
      {required String phoneNumber, String? avatar, String? name});

  Future<List<ModelUser>?> getFriend();
  Future<bool> addFriend({required String ownerUserId, required String userId});
  Future<bool> unFriend({required String ownerUserId, required String userId});
}
