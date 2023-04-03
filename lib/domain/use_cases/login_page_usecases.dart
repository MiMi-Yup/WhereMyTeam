import 'package:injectable/injectable.dart';
import 'package:where_my_team/domain/repositories/unit_of_work.dart';
import 'package:where_my_team/models/request/login_user_request.dart';
import 'package:where_my_team/models/request/new_user_request.dart';
import 'package:where_my_team/models/response/login_user_response.dart';
import 'package:where_my_team/models/user_model.dart';

@injectable
class LoginUseCases {
  final UnitOfWork unitOfWork;

  LoginUseCases({required this.unitOfWork});

  Future<UserModel?> login(String email, String password) async {
    LoginUserResponse? user = await unitOfWork.auth
        .loginByPassword(LoginUserRequest(email: email, password: password));
    if (user != null && user.token != null && user.token!.isNotEmpty) {
      await unitOfWork.preferences.setToken(user.token!);
    }
    return user?.user;
  }

  Future<UserModel?> signUp(String name, String email, String password) async {
    LoginUserResponse? user = await unitOfWork.auth
        .signUp(NewUserRequest(name: name, email: email, password: password));
    return user?.user;
  }
}
