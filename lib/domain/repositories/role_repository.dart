import 'package:wmteam/models/model_role.dart';

import 'generic_repository.dart';

abstract class RoleRepository extends GenericRepository {
  Future<ModelRole?> getRole({required String id});
  Future<bool> allowExecute(
      {required ModelRole source, required ModelRole target});
}
