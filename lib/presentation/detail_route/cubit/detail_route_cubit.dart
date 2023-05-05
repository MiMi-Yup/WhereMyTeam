import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:where_my_team/domain/use_cases/team_usecases.dart';

part 'detail_route_state.dart';

@injectable
class DetailRouteCubit extends Cubit<DetailRouteState> {
  final TeamUsercase homepageUseCases;

  DetailRouteCubit({
    required this.homepageUseCases,
  }) : super(DetailRouteState.initial());
}
