import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:location/location.dart';
import 'package:where_my_team/di/di.dart';
import 'package:where_my_team/domain/repositories/unit_of_work.dart';
import 'package:where_my_team/domain/use_cases/login_page_usecases.dart';
import 'package:where_my_team/models/model_member.dart';
import 'package:where_my_team/models/model_team.dart';
import 'package:where_my_team/models/model_team_user.dart';
import 'package:where_my_team/models/model_user.dart';

@injectable
class HomepageUseCases {
  final UnitOfWork unitOfWork;

  HomepageUseCases({required this.unitOfWork});

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
}
