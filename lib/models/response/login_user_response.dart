// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
import 'package:where_my_team/models/location_model.dart';
import 'package:where_my_team/models/user_model.dart';

part 'login_user_response.g.dart';

@JsonSerializable()
class LoginUserResponse {
  @JsonKey(name: "data")
  UserModel? user;
  @JsonKey(name: "token")
  String? token;

  LoginUserResponse({this.user, this.token});

  factory LoginUserResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginUserResponseToJson(this);
}