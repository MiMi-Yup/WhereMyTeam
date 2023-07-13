import 'package:configuration/route/route_define.dart';
import 'package:configuration/route/xmd_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmteam/di/di.dart';
import 'package:wmteam/manifest.dart';
import 'package:wmteam/presentation/friend_list/cubit/friend_list_cubit.dart';
import 'package:wmteam/presentation/friend_list/ui/friend_list_screen.dart';

class FriendListRoute extends RouteDefine {
  @override
  List<Path> initRoute(Map? arguments) => [
        Path(
          route: FriendListRoute,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<FriendListCubit>(
                create: (_) => getIt<FriendListCubit>(),
              ),
            ],
            child: const FriendListScreen(),
          ),
        ),
      ];

  static pushAndRemoveAll() {
    XMDRouter.pushNamedAndRemoveUntil(routerIds[FriendListRoute]!);
  }

  static popAndRemoveAll() {
    XMDRouter.popNamedAndRemoveUntil(routerIds[FriendListRoute]!);
  }
}
