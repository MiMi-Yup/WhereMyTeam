import 'package:where_my_team/models/model.dart';
import 'package:where_my_team/models/model_route.dart';
import 'package:where_my_team/models/model_user.dart';

import 'generic_repository.dart';

abstract class RouteRepository extends GenericRepository {
  Future<ModelRoute?> getRoute({required String id});
  Future<List<ModelRoute>?> getRoutes({String? id});

  Future<bool> putRouteShare({required String id, required bool state});

  Future<ModelRoute?> postRoute({required ModelRoute newRoute});

  Future<bool> deleteRoute({required IModel model});
}
