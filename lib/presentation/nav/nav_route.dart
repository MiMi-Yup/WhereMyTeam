import 'package:configuration/route/route_define.dart';
import 'package:configuration/route/xmd_router.dart';
import 'package:where_my_team/manifest.dart';
import 'package:where_my_team/presentation/nav/nav_screen.dart';

class NavRoute extends RouteDefine {
  @override
  List<Path> initRoute(Map? arguments) => [
        Path(route: NavRoute, builder: (_) => const Navigation()),
      ];

  static pushAndRemoveAll() {
    XMDRouter.pushNamedAndRemoveUntil(routerIds[NavRoute]!);
  }

  static popAndRemoveAll() {
    XMDRouter.popNamedAndRemoveUntil(routerIds[NavRoute]!);
  }
}
