import 'dart:async';

import 'package:configuration/environment/build_config.dart';
import 'package:configuration/environment/env.dart';
import 'package:configuration/route/route_define.dart';
import 'package:configuration/style/style.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wmteam/di/di.dart';
import 'package:wmteam/presentation/welcome/welcome_route.dart';
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

  Type startRoute = WelcomeRoute;

  @override
  FutureOr<void> onCreate() async {
    initRoute(routerIds);
    await Firebase.initializeApp();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    setStyleDefault();
  }

  @override
  Widget onCreateView() {
    ErrorWidget.builder = (FlutterErrorDetails details) {
      Zone.current.handleUncaughtError(details.exception, details.stack!);
      return Container(color: Colors.transparent);
    };
    return const MainApplication();
  }
}
