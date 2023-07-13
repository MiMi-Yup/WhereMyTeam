import 'package:configuration/route/route_define.dart';
import 'package:configuration/route/xmd_router.dart';
import 'package:wmteam/manifest.dart';
import 'package:wmteam/presentation/permission/permission_screen.dart';

class PermissionRoute extends RouteDefine {
  @override
  List<Path> initRoute(Map? arguments) => [
        Path(
          route: PermissionRoute,
          builder: (_) => const PermissionScreen(),
        ),
      ];

  static pushAndRemoveAll() {
    XMDRouter.pushNamedAndRemoveUntil(routerIds[PermissionRoute]!);
  }

  static popAndRemoveAll() {
    XMDRouter.popNamedAndRemoveUntil(routerIds[PermissionRoute]!);
  }
}
