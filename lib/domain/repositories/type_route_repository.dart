import 'package:where_my_team/domain/repositories/generic_repository.dart';
import 'package:where_my_team/models/model_type_route.dart';

abstract class TypeRouteRepository extends GenericRepository {
  Future<ModelTypeRoute?> getModelByName({required String name});
}