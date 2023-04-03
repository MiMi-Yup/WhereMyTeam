import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:where_my_team/data/data_source/remote/auth_service.dart';
import 'package:where_my_team/domain/repositories/auth_repository.dart';
import 'package:where_my_team/models/request/new_user_request.dart';
import 'package:where_my_team/models/request/login_user_request.dart';
import 'package:where_my_team/models/response/login_user_response.dart';
import 'package:where_my_team/utils/exception_util.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthService? authService;

  AuthRepositoryImpl({required this.authService});

  @override
  FutureOr<LoginUserResponse?> loginByPassword(LoginUserRequest login) {
    return authService?.login(login).catchError((onError){
      ExceptionUtil.handle(onError);
      return LoginUserResponse();
    });
  }

  @override
  FutureOr<LoginUserResponse?> signUp(NewUserRequest signUp) {
    return authService?.signUp(signUp);
  }
}
