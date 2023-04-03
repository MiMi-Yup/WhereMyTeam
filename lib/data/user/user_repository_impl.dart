import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:where_my_team/data/data_source/remote/api_service.dart';
import 'package:where_my_team/domain/repositories/user_repository.dart';
import 'package:where_my_team/models/response/get_user_response.dart';

@Injectable(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  ApiService? api;
  UserRepositoryImpl({this.api});

  @override
  FutureOr<GetUserResponse> getCurrentUser() {
    // TODO: implement GetCurrentUser
    throw UnimplementedError();
  }
}
