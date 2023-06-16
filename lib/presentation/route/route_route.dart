import 'package:configuration/route/route_define.dart';
import 'package:configuration/route/xmd_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_my_team/di/di.dart';
import 'package:where_my_team/domain/use_cases/route_usecases.dart';
import 'package:where_my_team/manifest.dart';
import 'package:where_my_team/presentation/route/cubit/route_cubit.dart';
import 'package:where_my_team/presentation/route/ui/route_screen.dart';

class RouteRoute extends RouteDefine {
  @override
  List<Path> initRoute(Map? arguments) => [
        Path(
          route: RouteRoute,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<RouteCubit>(
                create: (_) => RouteCubit(
                    usecase: getIt<RouteUseCases>(),
                    user: arguments?['user']),
              ),
            ],
            child: RouteScreen(),
          ),
        ),
      ];

  static pushAndRemoveAll() {
    XMDRouter.pushNamedAndRemoveUntil(routerIds[RouteRoute]!);
  }

  static popAndRemoveAll() {
    XMDRouter.popNamedAndRemoveUntil(routerIds[RouteRoute]!);
  }
}
