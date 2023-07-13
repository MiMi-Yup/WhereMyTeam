import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:wmteam/domain/repositories/unit_of_work.dart';
import 'package:wmteam/domain/use_cases/team_usecases.dart';
import 'package:wmteam/models/model_user.dart';

part 'add_friend_state.dart';

@injectable
class AddFriendCubit extends Cubit<AddFriendState> {
  final TeamUseCases usecase;
  final UnitOfWork uow;

  AddFriendCubit({required this.usecase, required this.uow})
      : super(AddFriendState.initial());

  void searchUser(String? search) {
    emit(state.copyWith(state: AddFriendEnum.searching, search: search));
  }

  Future<List<ModelUser>> searchResult() {
    return usecase.searchUser(state.search);
  }

  void changeName(String name) {
    emit(state.copyWith(name: name));
  }

  void addMember(ModelUser user) {
    if (!state.members.contains(user)) {
      emit(state.copyWith(
          members: List.from(state.members)..add(user),
          search: '',
          state: AddFriendEnum.completed));
    }
  }

  void removeMember(ModelUser user) {
    final find = state.members.firstWhere((element) => element.id == user.id);
    emit(state.copyWith(members: List.from(state.members)..remove(find)));
  }

  Future createTeam() {
    return Future.wait(
        state.members.map((e) => uow.friends.makeRequest(idUser: e.id!)));
  }
}
