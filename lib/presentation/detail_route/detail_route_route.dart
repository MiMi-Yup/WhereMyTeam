import 'package:configuration/route/route_define.dart';
import 'package:configuration/route/xmd_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmteam/di/di.dart';
import 'package:wmteam/domain/use_cases/route_usecases.dart';
import 'package:wmteam/manifest.dart';
import 'package:wmteam/presentation/detail_route/cubit/detail_route_cubit.dart';
import 'package:wmteam/presentation/detail_route/ui/detail_route_screen.dart';

class DetailRouteRoute extends RouteDefine {
  @override
  List<Path> initRoute(Map? arguments) => [
        Path(
          route: DetailRouteRoute,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<DetailRouteCubit>(
                create: (_) => DetailRouteCubit(
                    usecase: getIt<RouteUseCases>(),
                    route: arguments?['route']),
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
