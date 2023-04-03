import 'package:json_annotation/json_annotation.dart';
import 'package:where_my_team/models/location_model.dart';

part 'configuration_model.g.dart';

@JsonSerializable()
class ConfigurationModel{
  @JsonKey(name: 'userId')
  int? userId;
  @JsonKey(name: 'freezeLocation')
  bool freezeLocation = false;
  @JsonKey(name: 'shareNotification')
  bool shareNotification = true;

  ConfigurationModel({this.userId, this.freezeLocation = false, this.shareNotification = true});

  factory ConfigurationModel.fromJson(Map<String, dynamic> json) =>
      _$ConfigurationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigurationModelToJson(this);
}