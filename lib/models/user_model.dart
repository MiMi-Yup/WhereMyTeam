import 'package:json_annotation/json_annotation.dart';
import 'package:where_my_team/models/configuration_model.dart';
import 'package:where_my_team/models/location_model.dart';
import 'package:where_my_team/models/team_model.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel{
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'lastLocation')
  LocationModel? lastLocation;
  @JsonKey(name: 'team')
  List<TeamModel>? team;
  @JsonKey(name: 'configuration')
  ConfigurationModel? configuration;

  UserModel({this.id, this.name, this.email, this.lastLocation, this.team, this.configuration});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}