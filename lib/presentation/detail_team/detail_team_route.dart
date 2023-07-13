import 'package:configuration/route/route_define.dart';
import 'package:configuration/route/xmd_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmteam/di/di.dart';
import 'package:wmteam/domain/use_cases/team_usecases.dart';
import 'package:wmteam/manifest.dart';
import 'package:wmteam/presentation/detail_team/cubit/detail_team_cubit.dart';
import 'package:wmteam/presentation/detail_team/ui/detail_team_screen.dart';

class DetailTeamRoute extends RouteDefine {
  @override
  List<Path> initRoute(Map? arguments) => [
        Path(
          route: DetailTeamRoute,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<DetailTeamCubit>(
                  create: (_) => DetailTeamCubit(
                      usecase: getIt<TeamUseCases>(),
                      team: arguments?['team'])),
            ],
            child: const DetailTeamScreen(),
          ),
        ),
      ];

  static pushAndRemoveAll() {
    XMDRouter.pushNamedAndRemoveUntil(routerIds[DetailTeamRoute]!);
  }

  static popAndRemoveAll() {
    XMDRouter.popNamedAndRemoveUntil(routerIds[DetailTeamRoute]!);
  }
}
