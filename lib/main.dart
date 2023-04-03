import 'dart:async';

import 'package:configuration/environment/build_config.dart';
import 'package:configuration/environment/env.dart';
import 'package:configuration/route/route_define.dart';
import 'package:configuration/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:where_my_team/di/di.dart';
import 'package:where_my_team/domain/repositories/unit_of_work.dart';
import 'package:where_my_team/presentation/home_page/home_page_route.dart';
import 'package:where_my_team/presentation/start_page/start_page_route.dart';
import 'manifest.dart';
import 'presentation/main/main_application.dart';

const env = String.fromEnvironment('env', defaultValue: CustomEnv.prod);

/// EndPoint default
main() {
  SetupEnv();
}

class SetupEnv extends Env {
  @override
  Future? onInjection() async {
    configureDependencies(env: env);
  }

  Type startRoute = StartPageRoute;

  @override
  FutureOr<void> onCreate() async {
    initRoute(routerIds);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    setStyleDefault();
    final UnitOfWork unitOfWork = getIt<UnitOfWork>();
    String? token = await unitOfWork.preferences.getToken();
    if (token != null) {
      startRoute = HomePageRoute;
    }
  }

  @override
  Widget onCreateView() {
    ErrorWidget.builder = (FlutterErrorDetails details) {
      Zone.current.handleUncaughtError(details.exception, details.stack!);
      return Container(color: Colors.transparent);
    };
    return MainApplication(startRoute: startRoute);
  }
}
