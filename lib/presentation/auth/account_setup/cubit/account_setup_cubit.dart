import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:where_my_team/domain/use_cases/home_page_usecases.dart';
import 'package:where_my_team/models/model_team.dart';
import 'package:where_my_team/models/model_team_user.dart';
import 'package:where_my_team/models/model_user.dart';

part 'account_setup_state.dart';

@injectable
class AccountSetupCubit extends Cubit<AccountSetupState> {
  final HomepageUseCases homepageUseCases;

  AccountSetupCubit({
    required this.homepageUseCases,
  }) : super(AccountSetupState.initial());
}
