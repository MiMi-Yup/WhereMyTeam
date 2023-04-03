import 'package:json_annotation/json_annotation.dart';
import 'package:where_my_team/models/location_model.dart';
import 'package:where_my_team/models/team_member.dart';

part 'team_model.g.dart';

@JsonSerializable()
class TeamModel{
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'dateCreate')
  String? dateCreate;
  @JsonKey(name: 'teamMember')
  List<TeamMember>? teamMember;

  TeamModel({this.id, this.name, this.dateCreate, this.teamMember});

  factory TeamModel.fromJson(Map<String, dynamic> json) =>
      _$TeamModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeamModelToJson(this);
}