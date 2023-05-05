import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:where_my_team/domain/use_cases/team_usecases.dart';

part 'team_state.dart';

@injectable
class TeamCubit extends Cubit<TeamState> {
  final TeamUsercase teamUsercase;

  TeamCubit({
    required this.teamUsercase,
  }) : super(TeamState.initial());
}
