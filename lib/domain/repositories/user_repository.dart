import 'package:where_my_team/models/model_location.dart';
import 'package:where_my_team/models/model_user.dart';

import 'generic_repository.dart';

abstract class UserRepository extends GenericRepository {
  Future<ModelUser?> getCurrentUser();
  Future<ModelUser?> getUser({required String userId});
  Future<List<ModelUser>?> getUsers();

  Future<ModelUser?> postUserInitial();

  Future<bool> putLastLocation({required ModelLocation lastLocation});
  Future<bool> putFreezeLocation({required bool state});
  Future<bool> putShareNotification({required bool state});
  Future<bool> putBattery({required int level});
  Future<bool> putAvatar({required String path});
  Future<bool> putUserInitial(
      {required String phoneNumber, String? avatar, String? name});
}
