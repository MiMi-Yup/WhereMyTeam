import 'package:configuration/route/route_define.dart';
import 'package:configuration/route/xmd_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmteam/di/di.dart';
import 'package:wmteam/manifest.dart';
import 'package:wmteam/presentation/friend_request/cubit/friend_request_cubit.dart';
import 'package:wmteam/presentation/friend_request/ui/friend_request_screen.dart';

class FriendRequestRoute extends RouteDefine {
  @override
  List<Path> initRoute(Map? arguments) => [
        Path(
          route: FriendRequestRoute,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<FriendRequestCubit>(
                create: (_) => getIt<FriendRequestCubit>(),
              ),
            ],
            child: const FriendRequestScreen(),
          ),
        ),
      ];

  static pushAndRemoveAll() {
    XMDRouter.pushNamedAndRemoveUntil(routerIds[FriendRequestRoute]!);
  }

  static popAndRemoveAll() {
    XMDRouter.popNamedAndRemoveUntil(routerIds[FriendRequestRoute]!);
  }
}
