import 'package:configuration/route/xmd_router.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:wmteam/data/data_source/local/gps_service.dart';
import 'package:wmteam/data/services/battery_service.dart';
import 'package:wmteam/data/services/location_service.dart';
import 'package:wmteam/di/di.dart';
import 'package:wmteam/domain/use_cases/login_page_usecases.dart';
import 'package:wmteam/domain/use_cases/team_usecases.dart';
import 'package:wmteam/manifest.dart';
import 'package:wmteam/models/model_user.dart';
import 'package:wmteam/presentation/auth/account_setup/account_setup_route.dart';
import 'package:wmteam/presentation/bottom_bar/bottom_bar_route.dart';
import 'package:wmteam/presentation/introduction/introduction_route.dart';
import 'package:wmteam/presentation/permission/permission_route.dart';

part 'welcome_state.dart';

@injectable
class WelcomeCubit extends Cubit<WelcomeState> {
  final LoginUseCases loginUseCases;
  final TeamUseCases teamUseCases;

  WelcomeCubit({required this.loginUseCases, required this.teamUseCases})
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
          getIt<LocationServiceImpl>().userLogout();
          XMDRouter.pushNamedAndRemoveUntil(routerIds[IntroductionRoute]!);
        } else {
          if (!await loginUseCases.checkAlreadyUser(user.uid)) {
            // await loginUseCases.initUser(user);
            final ModelUser? resultUser = await XMDRouter.pushNamedForResult(
                routerIds[AccountSetupRoute]!,
                arguments: {'auth': user});
            if (resultUser != null) {
              resultUser.id = user.uid;
              resultUser.email = user.email;
              await loginUseCases.initUser(resultUser);
            }
          }
          getIt<LocationServiceImpl>().updateLocation();
          getIt<BatteryServiceImpl>().updateBattery();
          if (await getIt<GPSService>().isGranted) {
            XMDRouter.pushNamedAndRemoveUntil(routerIds[BottomBarRoute]!);
          } else {
            XMDRouter.pushNamedAndRemoveUntil(routerIds[PermissionRoute]!);
          }
        }
      }, onError: (error) {});
    }
  }
}
