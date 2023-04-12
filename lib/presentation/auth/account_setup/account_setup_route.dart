import 'package:configuration/route/route_define.dart';
import 'package:configuration/route/xmd_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_my_team/di/di.dart';
import 'package:where_my_team/manifest.dart';
import 'package:where_my_team/presentation/auth/account_setup/cubit/account_setup_cubit.dart';
import 'package:where_my_team/presentation/auth/account_setup/ui/account_setup_screen.dart';

class AccountSetupRoute extends RouteDefine {
  @override
  List<Path> initRoute(Map? arguments) => [
        Path(
          route: AccountSetupRoute,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<AccountSetupCubit>(
                create: (_) => getIt<AccountSetupCubit>(),
              )
            ],
            child: const AccountSetupScreen(),
          ),
        ),
      ];

  static pushAndRemoveAll() {
    XMDRouter.pushNamedAndRemoveUntil(routerIds[AccountSetupRoute]!);
  }

  static popAndRemoveAll() {
    XMDRouter.popNamedAndRemoveUntil(routerIds[AccountSetupRoute]!);
  }
}
