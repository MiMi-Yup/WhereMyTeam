import 'package:configuration/route/route_define.dart';
import 'package:configuration/route/xmd_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmteam/di/di.dart';
import 'package:wmteam/domain/use_cases/team_usecases.dart';
import 'package:wmteam/manifest.dart';
import 'package:wmteam/presentation/add_member/cubit/add_member_cubit.dart';
import 'package:wmteam/presentation/add_member/ui/add_member_screen.dart';

class AddMemberRoute extends RouteDefine {
  @override
  List<Path> initRoute(Map? arguments) => [
        Path(
          route: AddMemberRoute,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<AddMemberCubit>(
                create: (_) => AddMemberCubit(
                    usecase: getIt<TeamUseCases>(),
                    team: arguments?['team']),
              ),
            ],
            child: const AddMemberScreen(),
          ),
        ),
      ];

  static pushAndRemoveAll() {
    XMDRouter.pushNamedAndRemoveUntil(routerIds[AddMemberRoute]!);
  }

  static popAndRemoveAll() {
    XMDRouter.popNamedAndRemoveUntil(routerIds[AddMemberRoute]!);
  }
}
