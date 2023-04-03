import 'dart:async';

import 'package:where_my_team/models/request/login_user_request.dart';
import 'package:where_my_team/models/request/new_user_request.dart';
import 'package:where_my_team/models/response/get_user_response.dart';

abstract class UserRepository{
  FutureOr<GetUserResponse> getCurrentUser();
}