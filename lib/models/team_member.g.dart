// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamMember _$TeamMemberFromJson(Map<String, dynamic> json) => TeamMember(
      userId: json['userId'] as int?,
      teamId: json['teamId'] as int?,
      roleId: json['roleId'] as int?,
      joinDate: json['joinDate'] as String?,
    );

Map<String, dynamic> _$TeamMemberToJson(TeamMember instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'teamId': instance.teamId,
      'roleId': instance.roleId,
      'joinDate': instance.joinDate,
    };
