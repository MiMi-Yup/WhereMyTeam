import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:where_my_team/domain/use_cases/team_usecases.dart';
import 'package:where_my_team/models/model_member.dart';
import 'package:where_my_team/models/model_team.dart';
import 'package:where_my_team/models/model_user.dart';

part 'add_member_state.dart';

@injectable
class AddMemberCubit extends Cubit<AddMemberState> {
  final TeamUseCases usecase;
  final ModelTeam team;

  AddMemberCubit({required this.usecase, required this.team})
      : super(AddMemberState.initial());

  Future<bool> init() async {
    final member = await team.membersEx;
    if (member != null) {
      final existUser = await Future.wait(member.map((e) => e.userEx));
      if (existUser.isNotEmpty) {
        existUser.removeWhere((element) => element == null);
        emit(state.copyWith(
            members: List.from(state.members)
              ..addAll(existUser.cast<ModelUser>())));
      }
    }
    return true;
  }

  void searchUser(String? search) {
    emit(state.copyWith(state: Status.searching, search: search));
  }

  Future<List<ModelUser>> searchResult() async {
    final result = await usecase.searchUser(state.search);
    result.removeWhere((element) => state.members.contains(element));
    return result;
  }

  void addMember(ModelUser user) {
    if (!state.members.contains(user)) {
      emit(state.copyWith(
          members: List.from(state.members)..add(user),
          search: '',
          state: Status.completed));
    }
  }

  void removeMember(ModelUser user) {
    final find = state.members.firstWhere((element) => element.id == user.id);
    emit(state.copyWith(members: List.from(state.members)..remove(find)));
  }

  Future createTeam() {
    return usecase.addMembers(team: team, addUsers: state.members);
  }
}
