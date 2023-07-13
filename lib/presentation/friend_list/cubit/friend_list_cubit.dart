import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:wmteam/domain/use_cases/user_usecases.dart';
import 'package:wmteam/models/model_user.dart';
import 'package:wmteam/utils/alert_util.dart';

part 'friend_list_state.dart';

@injectable
class FriendListCubit extends Cubit<FriendListState> {
  final UserUseCases usecase;

  FriendListCubit({required this.usecase}) : super(FriendListState.initial());

  void init() async {
    emit(state.copyWith(members: await usecase.getFriend()));
  }

  void unFriend(ModelUser user) async {
    final ModelUser? currentUser =
        await usecase.unitOfWork.user.getCurrentUser();
    if (currentUser != null &&
        await usecase.unitOfWork.user
                .unFriend(ownerUserId: currentUser.id!, userId: user.id!) ==
            true &&
        await usecase.unitOfWork.user
                .unFriend(ownerUserId: user.id!, userId: currentUser.id!) ==
            true) {
      emit(state.copyWith(members: List.from(state.members)..remove(user)));
    } else {
      AlertUtil.showToast('Something wrong when accept');
    }
  }
}
