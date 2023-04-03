// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuration_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigurationModel _$ConfigurationModelFromJson(Map<String, dynamic> json) =>
    ConfigurationModel(
      userId: json['userId'] as int?,
      freezeLocation: json['freezeLocation'] as bool? ?? false,
      shareNotification: json['shareNotification'] as bool? ?? true,
    );

Map<String, dynamic> _$ConfigurationModelToJson(ConfigurationModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'freezeLocation': instance.freezeLocation,
      'shareNotification': instance.shareNotification,
    };
