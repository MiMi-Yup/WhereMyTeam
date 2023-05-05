import 'package:configuration/route/route_define.dart';
import 'package:configuration/route/xmd_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_my_team/di/di.dart';
import 'package:where_my_team/manifest.dart';
import 'package:where_my_team/presentation/detail_route/cubit/detail_route_cubit.dart';
import 'package:where_my_team/presentation/detail_route/ui/detail_route_screen.dart';

class DetailRouteRoute extends RouteDefine {
  @override
  List<Path> initRoute(Map? arguments) => [
        Path(
          route: DetailRouteRoute,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<DetailRouteCubit>(
                create: (_) => getIt<DetailRouteCubit>(),
              ),
            ],
            child: DetailRouteScreen(),
          ),
        ),
      ];

  static pushAndRemoveAll() {
    XMDRouter.pushNamedAndRemoveUntil(routerIds[DetailRouteRoute]!);
  }

  static popAndRemoveAll() {
    XMDRouter.popNamedAndRemoveUntil(routerIds[DetailRouteRoute]!);
  }
}
