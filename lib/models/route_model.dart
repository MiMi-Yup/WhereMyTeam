import 'package:json_annotation/json_annotation.dart';
import 'package:where_my_team/models/location_model.dart';

part 'route_model.g.dart';

@JsonSerializable()
class RouteModel{
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'startDate')
  String? startDate;
  @JsonKey(name: 'endDate')
  String? endDate;
  @JsonKey(name: 'share')
  bool? share;
  @JsonKey(name: 'location')
  List<LocationModel>? location;

  RouteModel({this.id, this.startDate, this.endDate, this.share, this.location});

  factory RouteModel.fromJson(Map<String, dynamic> json) =>
      _$RouteModelFromJson(json);

  Map<String, dynamic> toJson() => _$RouteModelToJson(this);
}