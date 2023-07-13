import 'package:wmteam/domain/repositories/generic_repository.dart';
import 'package:wmteam/models/model_type_route.dart';

abstract class TypeRouteRepository extends GenericRepository {
  Future<ModelTypeRoute?> getModelByName({required String name});
}