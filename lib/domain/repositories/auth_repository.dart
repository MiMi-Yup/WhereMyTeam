import 'dart:async';

import 'package:where_my_team/models/request/login_user_request.dart';
import 'package:where_my_team/models/request/new_user_request.dart';
import 'package:where_my_team/models/response/login_user_response.dart';

abstract class AuthRepository{
  FutureOr<LoginUserResponse?> signUp(NewUserRequest signUp);
  FutureOr<LoginUserResponse?> loginByPassword(LoginUserRequest login);
}