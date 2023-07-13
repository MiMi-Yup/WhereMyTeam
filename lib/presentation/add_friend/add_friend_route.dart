import 'package:configuration/route/route_define.dart';
import 'package:configuration/route/xmd_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmteam/di/di.dart';
import 'package:wmteam/manifest.dart';
import 'package:wmteam/presentation/add_friend/cubit/add_friend_cubit.dart';
import 'package:wmteam/presentation/add_friend/ui/add_friend_screen.dart';

class AddFriendRoute extends RouteDefine {
  @override
  List<Path> initRoute(Map? arguments) => [
        Path(
          route: AddFriendRoute,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<AddFriendCubit>(
                create: (_) => getIt<AddFriendCubit>(),
              ),
            ],
            child: const AddFriendScreen(),
          ),
        ),
      ];

  static pushAndRemoveAll() {
    XMDRouter.pushNamedAndRemoveUntil(routerIds[AddFriendRoute]!);
  }

  static popAndRemoveAll() {
    XMDRouter.popNamedAndRemoveUntil(routerIds[AddFriendRoute]!);
  }
}
