import 'package:configuration/route/route_define.dart';
import 'package:configuration/route/xmd_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_my_team/di/di.dart';
import 'package:where_my_team/manifest.dart';
import 'package:where_my_team/presentation/home/cubit/map_cubit.dart';
import 'cubit/home_cubit.dart';
import 'ui/home_screen.dart';

class HomeRoute extends RouteDefine {
  @override
  List<Path> initRoute(Map? arguments) => [
        Path(
          route: HomeRoute,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<HomeCubit>(
                create: (_) => getIt<HomeCubit>(),
              ),
              BlocProvider<MapCubit>(
                create: (_) => getIt<MapCubit>(),
              ),
            ],
            child: const HomeScreen(),
          ),
        ),
      ];

  static pushAndRemoveAll() {
    XMDRouter.pushNamedAndRemoveUntil(routerIds[HomeRoute]!);
  }

  static popAndRemoveAll() {
    XMDRouter.popNamedAndRemoveUntil(routerIds[HomeRoute]!);
  }
}
