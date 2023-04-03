// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationModel _$LocationModelFromJson(Map<String, dynamic> json) =>
    LocationModel(
      id: json['id'] as int?,
      userId: json['userId'] as int?,
      routeId: json['routeId'] as int?,
      altitude: (json['altitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: json['longitude'] as int?,
      satellite: (json['satelliteNumber'] as num?)?.toDouble(),
      speed: (json['speed'] as num?)?.toDouble(),
      timestamp: json['timestamp'] as String?,
    );

Map<String, dynamic> _$LocationModelToJson(LocationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'routeId': instance.routeId,
      'altitude': instance.altitude,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'satelliteNumber': instance.satellite,
      'speed': instance.speed,
      'timestamp': instance.timestamp,
    };
