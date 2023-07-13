import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:wmteam/domain/use_cases/user_usecases.dart';
import 'package:wmteam/models/model_user.dart';
import 'package:wmteam/utils/alert_util.dart';

part 'friend_request_state.dart';

@injectable
class FriendRequestCubit extends Cubit<FriendRequestState> {
  final UserUseCases usecase;

  FriendRequestCubit({required this.usecase})
      : super(FriendRequestState.initial());

  void init() async {
    emit(state.copyWith(members: await usecase.getRequestsFriend()));
  }

  void accept(ModelUser user) async {
    if (await usecase.unitOfWork.friends.makeAccept(idUser: user.id!) == true) {
      emit(state.copyWith(members: List.from(state.members)..remove(user)));
    } else {
      AlertUtil.showToast('Something wrong when accept');
    }
  }

  void denied(ModelUser user) async {
    if (await usecase.unitOfWork.friends.makeDenied(idUser: user.id!) == true) {
      emit(state.copyWith(members: List.from(state.members)..remove(user)));
    } else {
      AlertUtil.showToast('Something wrong when denied');
    }
  }
}
