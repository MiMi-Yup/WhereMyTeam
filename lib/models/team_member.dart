import 'package:json_annotation/json_annotation.dart';
import 'package:where_my_team/models/location_model.dart';
import 'package:where_my_team/models/user_model.dart';

part 'team_member.g.dart';

@JsonSerializable()
class TeamMember{
  @JsonKey(name: 'userId')
  int? userId;
  @JsonKey(name: 'teamId')
  int? teamId;
  @JsonKey(name: 'roleId')
  int? roleId;
  @JsonKey(name: 'joinDate')
  String? joinDate;

  TeamMember({this.userId, this.teamId, this.roleId, this.joinDate});

  factory TeamMember.fromJson(Map<String, dynamic> json) =>
      _$TeamMemberFromJson(json);

  Map<String, dynamic> toJson() => _$TeamMemberToJson(this);
}