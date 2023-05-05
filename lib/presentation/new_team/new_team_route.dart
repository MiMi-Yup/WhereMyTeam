import 'package:configuration/route/route_define.dart';
import 'package:configuration/route/xmd_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_my_team/di/di.dart';
import 'package:where_my_team/manifest.dart';
import 'package:where_my_team/presentation/new_team/cubit/new_team_cubit.dart';
import 'package:where_my_team/presentation/new_team/ui/new_team_screen.dart';

class NewTeamRoute extends RouteDefine {
  @override
  List<Path> initRoute(Map? arguments) => [
        Path(
          route: NewTeamRoute,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<NewTeamCubit>(
                create: (_) => getIt<NewTeamCubit>(),
              ),
            ],
            child: const NewTeamScreen(),
          ),
        ),
      ];

  static pushAndRemoveAll() {
    XMDRouter.pushNamedAndRemoveUntil(routerIds[NewTeamRoute]!);
  }

  static popAndRemoveAll() {
    XMDRouter.popNamedAndRemoveUntil(routerIds[NewTeamRoute]!);
  }
}
