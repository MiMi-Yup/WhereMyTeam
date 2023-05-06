import 'package:configuration/route/route_define.dart';
import 'package:configuration/route/xmd_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_my_team/di/di.dart';
import 'package:where_my_team/domain/use_cases/team_usecases.dart';
import 'package:where_my_team/manifest.dart';
import 'package:where_my_team/presentation/detail_team/cubit/detail_team_cubit.dart';
import 'package:where_my_team/presentation/detail_team/ui/detail_team_screen.dart';

class DetailTeamRoute extends RouteDefine {
  @override
  List<Path> initRoute(Map? arguments) => [
        Path(
          route: DetailTeamRoute,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<DetailTeamCubit>(
                  create: (_) => DetailTeamCubit(
                      teamUseCases: getIt<TeamUsercase>(),
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
