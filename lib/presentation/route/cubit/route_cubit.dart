import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:where_my_team/domain/use_cases/team_usecases.dart';

part 'route_state.dart';

@injectable
class RouteCubit extends Cubit<RouteState> {
  final TeamUsercase homepageUseCases;

  RouteCubit({
    required this.homepageUseCases,
  }) : super(RouteState.initial());
}
