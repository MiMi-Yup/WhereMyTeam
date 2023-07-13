import 'package:wmteam/models/model_friend_request.dart';

import 'generic_repository.dart';

abstract class FriendRequestRepository extends GenericRepository {
  Future<List<ModelFriendRequest>?> getRequests();
  Future<bool?> makeAccept({required String idUser});
  Future<bool?> makeDenied({required String idUser});
  Future<bool?> makeRequest({required String idUser});
}
