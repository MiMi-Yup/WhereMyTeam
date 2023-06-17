import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:where_my_team/domain/use_cases/user_usecases.dart';
import 'package:where_my_team/models/model_user.dart';
part 'account_setup_state.dart';

@injectable
class AccountSetupCubit extends Cubit<AccountSetupState> {
  final User? userAuth;
  final ModelUser? userModel;
  final UserUseCases usecase;
  AccountSetupCubit({this.userAuth, this.userModel, required this.usecase})
      : super(AccountSetupState(
            fullname: userModel?.name ?? userAuth?.displayName,
            phoneNumber: userModel?.phoneNumber ?? userAuth?.phoneNumber,
            avatar: null,
            initAvatar: userModel?.avatar ??
                userAuth?.photoURL ??
                'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png',
            state: Status.initial,
            signUp: userModel == null));

  void changeName(String name) {
    emit(state.copyWith(fullname: name));
  }

  void changePhoneNumber(String name) {
    emit(state.copyWith(phoneNumber: name));
  }

  void changeAvatar(String file) {
    emit(state.copyWith(avatar: file));
  }

  Future updateProfile() async {
    // emit(state.copyWith(state: Status.submitting));
    // ModelUser? newUpdate = await userUserCases
    //     .updateInfo(
    //         avatar: state.avatar, dob: state.dateOfBirth, name: state.fullname)
    //     .onError((error, stackTrace) {
    //   emit(state.copyWith(state: Status.error));
    //   return null;
    // });
    // if (newUpdate != null) {
    //   userUserCases.unitOfWork.session.updateUser(user: newUpdate);
    //   emit(state.copyWith(state: Status.success));
    // } else {
    //   emit(state.copyWith(state: Status.error));
    // }
    return Future.delayed(const Duration(seconds: 2));
  }
}
