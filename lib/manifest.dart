import 'package:where_my_team/presentation/auth/login/login_route.dart';
import 'package:where_my_team/presentation/introduction/introduction_route.dart';
import 'package:where_my_team/presentation/welcome/welcome_route.dart';

import 'presentation/home/home_route.dart';

const routerIds = {
  HomeRoute: 'HomeRoute',
  WelcomeRoute: 'WelcomeRoute',
  LoginRoute: 'LoginRoute',
  IntroductionRoute: 'IntroductionRoute'
};

void generateRoutes() {
  HomeRoute();
  WelcomeRoute();
  LoginRoute();
  IntroductionRoute();
}