import 'package:where_my_team/models/model_location.dart';

import 'generic_repository.dart';

abstract class LocationRepository extends GenericRepository {
  Future<ModelLocation?> getLocation({required String id});
  Future<List<ModelLocation>?> getDetailRoute({required String id});
}
