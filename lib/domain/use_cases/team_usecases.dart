import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';
import 'package:where_my_team/di/di.dart';
import 'package:where_my_team/domain/repositories/unit_of_work.dart';
import 'package:where_my_team/domain/use_cases/login_page_usecases.dart';
import 'package:where_my_team/models/model_member.dart';
import 'package:where_my_team/models/model_role.dart';
import 'package:where_my_team/models/model_team.dart';
import 'package:where_my_team/models/model_team_user.dart';
import 'package:where_my_team/models/model_user.dart';

@injectable
class TeamUsercase {
  final UnitOfWork unitOfWork;

  TeamUsercase({required this.unitOfWork});

  FutureOr<LocationData?> getCurrentLocation() async {
    LocationData? data = await unitOfWork.gps.getCurrentLocation();
    return data;
  }

  Future<Stream<LocationData>?> getStreamLocation() async {
    Stream<LocationData>? data = await unitOfWork.gps.getStream();
    return data;
  }

  Future<bool> checkAndAskPermission() async {
    bool? allow = await unitOfWork.gps.checkPermission();
    return allow ?? false;
  }

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
    RegExp regex = RegExp(r"^\d+$");
    if (regex.hasMatch(query)) {
      return result
          .where((element) => element.phoneNumber?.startsWith(query, 0) == true)
          .toList();
    }
    return result
        .where((element) => element.name?.startsWith(query, 0) == true)
        .toList();
  }

  Stream<QuerySnapshot<ModelTeamUser>> getStream() {
    return unitOfWork.teamUser.getStream();
  }

  Stream<QuerySnapshot<ModelMember>> getDetailStream(
      {required ModelTeam team}) {
    return unitOfWork.team.getStream(team: team);
  }

  Future createTeam(
      {required String name,
      required String avatar,
      List<ModelUser>? members}) async {
    final team = ModelTeam(
        id: null, name: name, createdAt: Timestamp.now(), avatar: avatar);
    if (await unitOfWork.team.postTeam(team: team)) {
      unitOfWork.user.getCurrentUser().then((author) {
        ModelRole admin =
            ModelRole(id: 'NtU957r3xX70qa260YeL', name: 'Admin', weightNo: 1);
        unitOfWork.memberTeam
            .postMember(team: team, user: author!, role: admin);
      });

      ModelRole member =
          ModelRole(id: 'Iaxzg3yMsu6IaXivpfZd', name: 'Member', weightNo: 2);
      Future.wait(members?.map((e) => unitOfWork.memberTeam.postMember(
          team: team, user: e, role: member)) as Iterable<Future<bool>>);

      unitOfWork.teamUser.addFavourite(team: team, users: members);
    }
  }
}
