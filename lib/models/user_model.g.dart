// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      lastLocation: json['lastLocation'] == null
          ? null
          : LocationModel.fromJson(
              json['lastLocation'] as Map<String, dynamic>),
      team: (json['team'] as List<dynamic>?)
          ?.map((e) => TeamModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      configuration: json['configuration'] == null
          ? null
          : ConfigurationModel.fromJson(
              json['configuration'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'lastLocation': instance.lastLocation,
      'team': instance.team,
      'configuration': instance.configuration,
    };
