import 'package:configuration/l10n/l10n.dart';
import 'package:configuration/route/xmd_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wmteam/common/widgets/m_primary_button.dart';
import 'package:wmteam/di/di.dart';
import 'package:wmteam/domain/use_cases/map_usecases.dart';
import 'package:wmteam/manifest.dart';
import 'package:wmteam/presentation/bottom_bar/bottom_bar_route.dart';

class PermissionScreen extends StatelessWidget {
  const PermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: Text(MultiLanguage.of(context).requestPermission)),
        body: Column(children: [
          Expanded(child: Text(MultiLanguage.of(context).contentPermission)),
          Row(children: [
            Expanded(
                child: MPrimaryButton(
                    text: MultiLanguage.of(context).denied,
                    onPressed: () async => await SystemNavigator.pop())),
            Expanded(
                child: MPrimaryButton(
                    text: MultiLanguage.of(context).accept,
                    onPressed: () async {
                      bool allow =
                          await getIt<MapUseCases>().checkAndAskPermission();
                      if (allow) {
                        XMDRouter.popAndPushNamed(routerIds[BottomBarRoute]!);
                      } else {
                        await SystemNavigator.pop();
                      }
                    }))
          ])
        ]));
  }
}
