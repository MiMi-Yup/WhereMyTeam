import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:wmteam/data/data_source/remote/cloud_storage_service.dart';
import 'package:wmteam/di/di.dart';
import 'package:wmteam/domain/repositories/unit_of_work.dart';
import 'package:wmteam/domain/use_cases/login_page_usecases.dart';
import 'package:wmteam/models/model.dart';
import 'package:wmteam/models/model_member.dart';
import 'package:wmteam/models/model_role.dart';
import 'package:wmteam/models/model_team.dart';
import 'package:wmteam/models/model_team_user.dart';
import 'package:wmteam/models/model_user.dart';

@injectable
class TeamUseCases {
  final UnitOfWork unitOfWork;

  TeamUseCases({required this.unitOfWork});

  Future<ModelUser?> getCurrentUser() {
    return unitOfWork.user.getCurrentUser();
  }

  Future<List<ModelTeam>?> getTeams() async {
    List<ModelTeamUser>? team = await unitOfWork.teamUser.getTeams();
    if (team != null) {
      return (await Future.wait<ModelTeam?>(
              team.map((e) => unitOfWork.team.getTeam(teamId: e.id!))))
          .where((element) => element != null)
          .cast<ModelTeam>()
          .toList();
    }
    return null;
  }

  Future<List<ModelMember>?> getTeamMembers(ModelTeam team) {
    return unitOfWork.team.getMembers(teamId: team.id!);
  }

  Future<void> logOut() async {
    await getIt<LoginUseCases>().signOut();
  }

  Future<List<ModelUser>> searchUser(String? query) async {
    if (query == null || query.isEmpty) return [];
    List<ModelUser>? result = await unitOfWork.user.getUsers();
    if (result == null) return [];
    final queryLower = query.toLowerCase();
    RegExp regex = RegExp(r"^\d+$");
    if (regex.hasMatch(query)) {
      result.retainWhere(
          (element) => element.phoneNumber?.startsWith(queryLower, 0) == true);
    } else {
      result.retainWhere((element) =>
          element.name
              ?.toLowerCase()
              .split(' ')
              .any((element) => element.startsWith(queryLower, 0) == true) ==
          true);
    }
    final currentUser = await getCurrentUser();
    result.removeWhere((element) => element.id == currentUser?.id);
    return result;
  }

  Stream<QuerySnapshot<ModelTeamUser>> getStream() {
    return unitOfWork.teamUser.getStream();
  }

  Future<List> getFamilyStream() async {
    ModelTeamUser? teamUser = await unitOfWork.user.getFamilyTeam();
    ModelTeam? team = await teamUser?.teamEx;
    if (teamUser == null || team == null) return [];
    return [unitOfWork.team.getStream(team: team), team];
  }

  Stream<QuerySnapshot<ModelMember>> getDetailStream(
      {required ModelTeam team}) {
    return unitOfWork.team.getStream(team: team);
  }

  Future<IModel?> getInfo(String id) {
    return unitOfWork.team.getModelByRef(unitOfWork.team.getRefById(id));
  }

  Future createTeam(
      {required String name,
      required String avatar,
      List<ModelUser>? members,
      bool isFamilyTeam = false}) async {
    final team = ModelTeam(
        id: null,
        name: name,
        createdAt: Timestamp.now(),
        avatar: avatar,
        isFamilyTeam: isFamilyTeam);
    if (await unitOfWork.team.postTeam(team: team)) {
      final updateAvatar = 'team/${team.id}/image.png';
      await CloudStorageService.uploadFile(File(avatar), updateAvatar);
      await unitOfWork.team.putAvatar(team: team, path: updateAvatar);
      unitOfWork.user.getCurrentUser().then((author) {
        ModelRole admin =
            ModelRole(id: 'NtU957r3xX70qa260YeL', name: 'Admin', weightNo: 1);
        unitOfWork.memberTeam
            .postMember(team: team, user: author!, role: admin);
      });

      ModelRole member =
          ModelRole(id: 'Iaxzg3yMsu6IaXivpfZd', name: 'Member', weightNo: 2);
      if (members != null && members.isNotEmpty) {
        Future.wait(members.map((e) => unitOfWork.memberTeam
            .postMember(team: team, user: e, role: member)));
      }

      unitOfWork.teamUser.addFavourite(team: team, users: members);
    }
  }

  Future addMembers(
      {required ModelTeam team, required List<ModelUser> addUsers}) async {
    ModelRole member =
        ModelRole(id: 'Iaxzg3yMsu6IaXivpfZd', name: 'Member', weightNo: 2);
    final members = await team.membersEx;
    if (members != null) {
      final users = await Future.wait(members.map((e) => e.userEx));
      if (users.isNotEmpty) {
        users.removeWhere((element) => element == null);
        addUsers.removeWhere((element) => users.contains(element));
      }
    }
    return Future.wait(addUsers.map((e) =>
        unitOfWork.memberTeam.postMember(team: team, user: e, role: member)));
  }

  Future<bool> isAdminOfTeam({required ModelTeam team}) async {
    final member = await unitOfWork.team.adminOfTeam(team: team);
    final adminUser = await member?.userEx;
    final currentUser = await unitOfWork.user.getCurrentUser();
    return adminUser != null &&
        currentUser != null &&
        adminUser.id == currentUser.id;
  }

  Future outTeam({required ModelTeam team, ModelUser? user}) async {
    ModelUser? currentUser = await unitOfWork.user.getCurrentUser();
    ModelMember? current = currentUser == null
        ? null
        : await unitOfWork.memberTeam.getMember(team: team, user: currentUser);
    if (current == null) return;
    if (user != null) {
      //kick
      ModelMember? member =
          await unitOfWork.memberTeam.getMember(team: team, user: user);
      ModelRole? role = await member?.roleEx;
      ModelRole? roleCurrent = await current.roleEx;
      if (member != null &&
          (roleCurrent?.weightNo ?? 5) <= (role?.weightNo ?? 5)) {
        unitOfWork.memberTeam.deleteMember(member: member);
      }
      unitOfWork.teamUser.removeFavourite(team: team, user: user);
    } else {
      //leave team
      unitOfWork.memberTeam.deleteMember(member: current);
    }
    //remove favourites
    unitOfWork.teamUser.removeFavourite(team: team, user: user ?? currentUser!);
    return Future.delayed(const Duration(seconds: 2));
  }

  Future setNickname({required ModelMember member, required String nickname}) {
    unitOfWork.memberTeam.putNickname(member: member, nickname: nickname);
    return Future.delayed(const Duration(seconds: 2));
  }

  Future deleteTeam({required ModelTeam team}) {
    unitOfWork.team.deleteTeam(team: team);
    unitOfWork.teamUser.deleteTeam(team: team);
    //remove team user
    return Future.delayed(const Duration(seconds: 2));
  }
}
