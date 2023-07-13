import 'package:configuration/route/route_define.dart';
import 'package:configuration/route/xmd_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmteam/di/di.dart';
import 'package:wmteam/domain/use_cases/user_usecases.dart';
import 'package:wmteam/manifest.dart';
import 'package:wmteam/presentation/auth/account_setup/cubit/account_setup_cubit.dart';
import 'package:wmteam/presentation/auth/account_setup/ui/account_setup_screen.dart';

class AccountSetupRoute extends RouteDefine {
  @override
  List<Path> initRoute(Map? arguments) => [
        Path(
          route: AccountSetupRoute,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<AccountSetupCubit>(
                create: (_) => AccountSetupCubit(
                    usecase: getIt<UserUseCases>(),
                    userAuth: arguments?['auth'],
                    userModel: arguments?['model']),
              )
            ],
            child: AccountSetupScreen(),
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
