import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:where_my_team/models/model.dart';
import 'package:where_my_team/models/model_location.dart';
import 'package:where_my_team/models/model_route.dart';

import 'generic_repository.dart';

abstract class RouteRepository extends GenericRepository {
  Future<ModelRoute?> getRoute({required String id});
  Future<List<ModelRoute>?> getRoutes();

  Future<bool> putRouteShare({required String id, required bool state});

  Future<ModelRoute?> postRoute({required ModelRoute newRoute});

  Future<bool> deleteRoute({required IModel model});
}