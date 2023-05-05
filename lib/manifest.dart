import 'package:where_my_team/presentation/auth/login/login_route.dart';
import 'package:where_my_team/presentation/detail_route/detail_route_route.dart';
import 'package:where_my_team/presentation/detail_team/detail_team_route.dart';
import 'package:where_my_team/presentation/introduction/introduction_route.dart';
import 'package:where_my_team/presentation/nav/nav_route.dart';
import 'package:where_my_team/presentation/new_team/new_team_route.dart';
import 'package:where_my_team/presentation/route/route_route.dart';
import 'package:where_my_team/presentation/welcome/welcome_route.dart';

const routerIds = {
  WelcomeRoute: 'WelcomeRoute',
  LoginRoute: 'LoginRoute',
  IntroductionRoute: 'IntroductionRoute',
  NavRoute: 'NavRoute',
  DetailTeamRoute: 'DetailTeamRoute',
  RouteRoute: 'RouteRoute',
  DetailRouteRoute: 'DetailRouteRoute',
  NewTeamRoute: 'NewTeamRoute',
};

void generateRoutes() {
  WelcomeRoute();
  LoginRoute();
  IntroductionRoute();
  NavRoute();
  DetailTeamRoute();
  RouteRoute();
  DetailRouteRoute();
  NewTeamRoute();
}
