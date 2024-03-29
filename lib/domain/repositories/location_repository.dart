import 'package:wmteam/models/model_location.dart';
import 'package:wmteam/models/model_route.dart';

import 'generic_repository.dart';

abstract class LocationRepository extends GenericRepository {
  Future<ModelLocation?> getLocation({required String id});
  Future<List<ModelLocation>?> getDetailRoute(ModelRoute model);
}
