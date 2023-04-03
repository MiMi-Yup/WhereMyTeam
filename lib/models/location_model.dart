import 'package:json_annotation/json_annotation.dart';

part 'location_model.g.dart';

@JsonSerializable()
class LocationModel{
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'userId')
  int? userId;
  @JsonKey(name: 'routeId')
  int? routeId;
  @JsonKey(name: 'altitude')
  double? altitude;
  @JsonKey(name: 'latitude')
  double? latitude;
  @JsonKey(name: 'longitude')
  int? longitude;
  @JsonKey(name: 'satelliteNumber')
  double? satellite;
  @JsonKey(name: 'speed')
  double? speed;
  @JsonKey(name: 'timestamp')
  String? timestamp;

  LocationModel({this.id, this.userId, this.routeId, this.altitude, this.latitude, this.longitude, this.satellite, this.speed,this.timestamp});

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}