import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:where_my_team/domain/use_cases/team_usecases.dart';
import 'package:where_my_team/models/model_user.dart';

part 'new_team_state.dart';

@injectable
class NewTeamCubit extends Cubit<NewTeamState> {
  final TeamUsercase teamUsercase;

  NewTeamCubit({
    required this.teamUsercase,
  }) : super(NewTeamState.initial());

  void searchUser(String? search) {
    emit(state.copyWith(state: NewTeamEnum.searching, search: search));
  }

  Future<List<ModelUser>> searchResult() {
    return teamUsercase.searchUser(state.search);
  }

  void changeAvatar(String avatar) {
    emit(state.copyWith(avatar: avatar));
  }

  void changeName(String name) {
    emit(state.copyWith(name: name));
  }

  void addMember(ModelUser user) {
    emit(state.copyWith(
        members: List.from(state.members)..add(user),
        search: '',
        state: NewTeamEnum.completed));
  }

  void removeMember(ModelUser user) {
    final find = state.members.firstWhere((element) => element.id == user.id);
    emit(state.copyWith(members: List.from(state.members)..remove(find)));
  }

  Future createTeam() async {
    teamUsercase.createTeam(
        name: state.name ?? 'yolo',
        avatar: state.avatar ??
            'https://www.rd.com/wp-content/uploads/2020/11/redo-cat-meme6.jpg?w=1414',
        members: state.members);
  }
}
