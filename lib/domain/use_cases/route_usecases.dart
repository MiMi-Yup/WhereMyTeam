import 'package:injectable/injectable.dart';
import 'package:wmteam/domain/repositories/unit_of_work.dart';

@injectable
class RouteUseCases {
  final UnitOfWork unitOfWork;

  RouteUseCases({required this.unitOfWork});
}
