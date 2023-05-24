import 'package:configuration/route/xmd_router.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:where_my_team/data/services/location_service.dart';
import 'package:where_my_team/di/di.dart';
import 'package:where_my_team/domain/use_cases/login_page_usecases.dart';
import 'package:where_my_team/domain/use_cases/team_usecases.dart';
import 'package:where_my_team/manifest.dart';
import 'package:where_my_team/models/model_user.dart';
import 'package:where_my_team/presentation/bottom_bar/bottom_bar_route.dart';
import 'package:where_my_team/presentation/introduction/introduction_route.dart';

part 'welcome_state.dart';

@injectable
class WelcomeCubit extends Cubit<WelcomeState> {
  final LoginUseCases loginUseCases;
  final TeamUsercase teamUsercase;

  WelcomeCubit({required this.loginUseCases, required this.teamUsercase})
      : super(WelcomeState.initial());

  void init() async {
    ModelUser? user = await loginUseCases.loginRemember();
    if (user != null) {
      emit(state.copyWith(status: WelcomeStatus.login));
    } else {
      emit(state.copyWith(status: WelcomeStatus.newUser));
    }

    if (!loginUseCases.authService.assignEvent) {
      loginUseCases.authService.assignEvent = true;
      loginUseCases.authService.service.authStateChanges().listen((user) async {
        if (user == null) {
          XMDRouter.pushNamedAndRemoveUntil(routerIds[IntroductionRoute]!);
        } else {
          if (!await loginUseCases.checkAlreadyUser(user.uid)) {
            await loginUseCases.initUser();
            await teamUsercase.createTeam(
                isFamilyTeam: true,
                name: 'Family',
                avatar:
                    'https://www.rd.com/wp-content/uploads/2020/11/redo-cat-meme6.jpg?w=1414');
          }
          getIt<LocationServiceImpl>().updateLocation();
          XMDRouter.pushNamedAndRemoveUntil(routerIds[BottomBarRoute]!);
        }
      }, onError: (error) {});
    }
  }
}
