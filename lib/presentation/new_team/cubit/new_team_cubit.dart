import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:wmteam/domain/use_cases/team_usecases.dart';
import 'package:wmteam/domain/use_cases/user_usecases.dart';
import 'package:wmteam/models/model_user.dart';

part 'new_team_state.dart';

@injectable
class NewTeamCubit extends Cubit<NewTeamState> {
  final TeamUseCases usecase;
  final UserUseCases userUseCases;

  NewTeamCubit({required this.usecase, required this.userUseCases})
      : super(NewTeamState.initial());

  void init() async {
    emit(state.copyWith(friends: await userUseCases.getFriend()));
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
        friends: List.from(state.friends)..remove(user),
        state: NewTeamEnum.completed));
  }

  void removeMember(ModelUser user) {
    emit(state.copyWith(
      members: List.from(state.members)..remove(user),
      friends: List.from(state.friends)..add(user),
    ));
  }

  Future createTeam() {
    return usecase.createTeam(
        name: state.name ?? 'yolo',
        avatar: state.avatar ?? 'avatar/fqAueJqQeKcgMJwJFCjsC2atiHj2/image.png',
        members: state.members);
  }
}
