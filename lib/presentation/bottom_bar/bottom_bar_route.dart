import 'package:configuration/route/route_define.dart';
import 'package:configuration/route/xmd_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmteam/di/di.dart';
import 'package:wmteam/domain/use_cases/map_usecases.dart';
import 'package:wmteam/presentation/bottom_bar/cubit/bottom_bar_cubit.dart';
import 'package:wmteam/presentation/bottom_bar/ui/bottom_bar_screen.dart';
import 'package:wmteam/presentation/map/cubit/map_cubit.dart';
import 'package:wmteam/presentation/map/cubit/team_map_cubit.dart';

import '../../manifest.dart';

class BottomBarRoute extends RouteDefine {
  @override
  List<Path> initRoute(Map? arguments) => [
        Path(
          route: BottomBarRoute,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => getIt<BottomBarCubit>()),
              BlocProvider(create: (_) => getIt<TeamMapCubit>()),
              BlocProvider<MapCubit>(
                create: (context) => MapCubit(
                    usecase: getIt<MapUseCases>(),
                    userCubit: BlocProvider.of<TeamMapCubit>(context)),
              ),
            ],
            child: BottomBarScreen(),
          ),
        ),
      ];

  static pushAndRemoveAll() {
    XMDRouter.pushNamedAndRemoveUntil(routerIds[BottomBarRoute]!);
  }

  static popAndRemoveAll() {
    XMDRouter.popNamedAndRemoveUntil(routerIds[BottomBarRoute]!);
  }
}
