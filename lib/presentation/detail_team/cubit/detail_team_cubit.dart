import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:wmteam/domain/use_cases/team_usecases.dart';
import 'package:wmteam/models/model_member.dart';
import 'package:wmteam/models/model_team.dart';

part 'detail_team_state.dart';

@injectable
class DetailTeamCubit extends Cubit<DetailTeamState> {
  final TeamUseCases usecase;
  late ModelTeam team;

  DetailTeamCubit({required this.usecase, required this.team})
      : super(DetailTeamState.initial()) {
    usecase
        .isAdminOfTeam(team: team)
        .then((value) => emit(state.copyWith(isAdminOfTeam: value)));
    usecase.getInfo(team.id!).then((value) {
      if (value is ModelTeam) {
        emit(state.copyWith(team: value));
      }
    });
  }

  Stream<QuerySnapshot<ModelMember>> getStream() {
    return usecase.getDetailStream(team: team);
  }

  void changeNickname(ModelMember member, String nickname) {
    usecase.setNickname(member: member, nickname: nickname);
  }

  Future<bool> kick(ModelMember? member) async {
    final removeUser = await member?.userEx;
    await usecase.outTeam(team: team, user: removeUser);
    return true;
  }

  Future deleteTeam() {
    return usecase.deleteTeam(team: team);
  }
}
