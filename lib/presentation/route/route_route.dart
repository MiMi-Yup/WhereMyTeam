import 'package:configuration/route/route_define.dart';
import 'package:configuration/route/xmd_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmteam/di/di.dart';
import 'package:wmteam/domain/use_cases/route_usecases.dart';
import 'package:wmteam/manifest.dart';
import 'package:wmteam/presentation/route/cubit/route_cubit.dart';
import 'package:wmteam/presentation/route/ui/route_screen.dart';

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
            child: const RouteScreen(),
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
