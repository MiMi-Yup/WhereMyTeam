import 'package:injectable/injectable.dart';
import 'package:where_my_team/domain/repositories/unit_of_work.dart';

@injectable
class UserUseCases {
  final UnitOfWork unitOfWork;

  UserUseCases({required this.unitOfWork});
}