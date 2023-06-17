import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:where_my_team/di/di.dart';
import 'package:where_my_team/domain/repositories/unit_of_work.dart';
import 'package:where_my_team/domain/use_cases/user_usecases.dart';
import 'package:where_my_team/presentation/map/ui/map_screen.dart';
import 'package:where_my_team/presentation/profile/profile_screen.dart';
import 'package:where_my_team/presentation/team/team_page.dart';

part 'bottom_bar_state.dart';

@injectable
class BottomBarCubit extends Cubit<BottomBarState> {
  final UnitOfWork unitOfWork;
  BottomBarCubit({required this.unitOfWork})
      : super(BottomBarInitial(currentIndex: 0));

  final List<Widget> listPage = [
    const TeamPage(),
    const MapScreen(),
    ProfileScreen(
      usecase: getIt<UserUseCases>(),
    )
  ];

  void changePage(int i) {
    emit(BottomBarInitial(currentIndex: i));
  }

  void toggleBottomBar(bool isFullMode) {
    if (state is BottomBarInitial) {
      emit((state as BottomBarInitial).copyWith(isHidden: isFullMode));
    }
  }
}
