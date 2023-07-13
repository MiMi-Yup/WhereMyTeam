import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wmteam/models/model.dart';
import 'package:wmteam/models/model_route.dart';

import 'generic_repository.dart';

abstract class RouteRepository extends GenericRepository {
  Future<ModelRoute?> getRoute({required String id});
  Future<List<ModelRoute>?> getRoutes({String? id});

  Future<bool> putRouteShare({required String id, required bool state});

  Future<ModelRoute?> postRoute({required ModelRoute newRoute});

  Future<bool> deleteRoute({required IModel model});

  DocumentReference<Map<String, dynamic>> getRefEx(
      {required String idUser, required String idRouter});
}
