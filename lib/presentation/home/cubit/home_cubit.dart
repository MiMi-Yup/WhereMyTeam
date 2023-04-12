import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:where_my_team/domain/use_cases/home_page_usecases.dart';
import 'package:where_my_team/models/model_location.dart';
import 'package:where_my_team/models/model_member.dart';
import 'package:where_my_team/models/model_team.dart';
import 'package:where_my_team/models/model_team_user.dart';
import 'package:where_my_team/models/model_user.dart';
import 'package:where_my_team/utils/time_util.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final HomepageUseCases homepageUseCases;

  HomeCubit({
    required this.homepageUseCases,
  }) : super(HomeState.initial());

  Future<List<ModelTeam>?> getTeams() {
    return homepageUseCases.getTeams();
  }

  Future<void> changeTeam(ModelTeam team) async {
    emit(state.copyWith(
        currentTeam: team,
        teamMembers: await homepageUseCases.getTeamMembers(team)));
  }

  Future<Map<String, Object?>?> getInfoMember(int index) async {
    if (state.teamMembers != null &&
        index >= 0 &&
        state.teamMembers!.length > index) {
      ModelMember member = state.teamMembers![index];
      ModelUser? user = await member.userEx;
      ModelLocation? lastLocation = await user?.lastLocationEx;
      return {
        'id': member.id,
        'name': user?.name,
        'avatar': user?.avatar,
        'battery': user?.percentBatteryDevice,
        'lastOnline': lastLocation?.timestamp?.toShortTime,
        'location:': 'Near somewhere',
        // 'isFavourite': member.isFavourite
      };
    }
    return null;
  }

  Future<void> logOut() async {
    await homepageUseCases.logOut();
  }
}