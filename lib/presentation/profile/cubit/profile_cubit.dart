import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:wmteam/domain/use_cases/team_usecases.dart';
import 'package:wmteam/domain/use_cases/user_usecases.dart';
import 'package:wmteam/models/model_user.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final TeamUseCases usecase;
  final UserUseCases userUseCases;

  ProfileCubit({required this.usecase, required this.userUseCases})
      : super(ProfileState.initial());

  void updateProfile(ModelUser user) {}

  Future<int> getCountRequestsFriend() {
    return userUseCases.getCountRequestsFriend();
  }
}
