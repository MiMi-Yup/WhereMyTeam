import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:where_my_team/domain/use_cases/team_usecases.dart';
import 'package:where_my_team/models/model.dart';
import 'package:where_my_team/models/model_member.dart';
import 'package:where_my_team/models/model_team.dart';

part 'detail_team_state.dart';

@injectable
class DetailTeamCubit extends Cubit<DetailTeamState> {
  final TeamUsercase teamUseCases;
  late ModelTeam team;

  DetailTeamCubit({required this.teamUseCases, required this.team})
      : super(DetailTeamState.initial());

  Future<ModelTeam?> getFullInfo() async {
    IModel? model = await teamUseCases.getInfo(team.id!);
    if (model is ModelTeam) {
      team = model;
      return team;
    }
    return null;
  }

  Stream<QuerySnapshot<ModelMember>> getStream() {
    return teamUseCases.getDetailStream(team: team);
  }
}
