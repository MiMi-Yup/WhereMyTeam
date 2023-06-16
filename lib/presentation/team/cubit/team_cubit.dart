import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:where_my_team/domain/use_cases/team_usecases.dart';
import 'package:where_my_team/models/model_member.dart';
import 'package:where_my_team/models/model_team.dart';
import 'package:where_my_team/models/model_team_user.dart';

part 'team_state.dart';

@injectable
class TeamCubit extends Cubit<TeamState> {
  final TeamUseCases usecase;

  TeamCubit({
    required this.usecase,
  }) : super(TeamState.initial());

  Stream<QuerySnapshot<ModelTeamUser>> getStreamTeam() {
    return usecase.getStream();
  }

  Future<Stream<QuerySnapshot<ModelMember>>?> getMembersOfPrimaryTeam() async {
    final result = await usecase.getFamilyStream();
    if (result.length == 2) {
      emit(state.copyWith(familyTeam: result.last));
      return result.first;
    }
    return null;
  }

  Future leaveTeam(ModelTeam team) {
    return usecase.outTeam(team: team);
  }
}
