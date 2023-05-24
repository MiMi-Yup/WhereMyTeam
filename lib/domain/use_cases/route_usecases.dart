import 'package:injectable/injectable.dart';
import 'package:where_my_team/domain/repositories/unit_of_work.dart';

@injectable
class RouteUsercase {
  final UnitOfWork unitOfWork;

  RouteUsercase({required this.unitOfWork});
}
