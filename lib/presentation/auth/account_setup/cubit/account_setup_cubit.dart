import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:where_my_team/models/model_user.dart';
part 'account_setup_state.dart';

@injectable
class AccountSetupCubit extends Cubit<AccountSetupState> {
  final User? userAuth;
  final ModelUser? userModel;
  AccountSetupCubit({this.userAuth, this.userModel})
      : super(AccountSetupState(
            fullname: userAuth?.displayName ?? userModel?.name,
            phoneNumber: userAuth?.phoneNumber ?? userModel?.phoneNumber,
            avatar: null,
            state: Status.initial));

  void changeName(String name) {
    emit(state.copyWith(fullname: name));
  }

  void changePhoneNumber(String name) {
    emit(state.copyWith(phoneNumber: name));
  }

  void changeAvatar(String file) {
    emit(state.copyWith(avatar: file));
  }
}
