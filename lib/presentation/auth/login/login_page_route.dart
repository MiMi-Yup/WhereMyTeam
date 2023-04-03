import 'package:configuration/route/route_define.dart';
import 'package:configuration/route/xmd_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_my_team/di/di.dart';
import 'package:where_my_team/manifest.dart';
import 'package:where_my_team/presentation/auth/login/cubit/login_page_cubit.dart';
import 'package:where_my_team/presentation/auth/login/ui/login_page_screen.dart';

class LoginPageRoute extends RouteDefine {
  @override
  List<Path> initRoute(Map? arguments) => [
        Path(
          route: LoginPageRoute,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<LoginPageCubit>(
                create: (_) => getIt<LoginPageCubit>(),
              ),
            ],
            child: const LoginPageScreen(),
          ),
        ),
      ];

  static pushAndRemoveAll() {
    XMDRouter.pushNamedAndRemoveUntil(routerIds[LoginPageRoute]!);
  }

  static popAndRemoveAll() {
    XMDRouter.popNamedAndRemoveUntil(routerIds[LoginPageRoute]!);
  }
}