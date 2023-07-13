import 'package:wmteam/presentation/add_friend/add_friend_route.dart';
import 'package:wmteam/presentation/add_member/add_member_route.dart';
import 'package:wmteam/presentation/auth/account_setup/account_setup_route.dart';
import 'package:wmteam/presentation/auth/login/login_route.dart';
import 'package:wmteam/presentation/bottom_bar/bottom_bar_route.dart';
import 'package:wmteam/presentation/detail_route/detail_route_route.dart';
import 'package:wmteam/presentation/detail_team/detail_team_route.dart';
import 'package:wmteam/presentation/friend_list/friend_list_route.dart';
import 'package:wmteam/presentation/friend_request/friend_request_route.dart';
import 'package:wmteam/presentation/introduction/introduction_route.dart';
import 'package:wmteam/presentation/new_team/new_team_route.dart';
import 'package:wmteam/presentation/permission/permission_route.dart';
import 'package:wmteam/presentation/route/route_route.dart';
import 'package:wmteam/presentation/welcome/welcome_route.dart';

const routerIds = {
  WelcomeRoute: 'WelcomeRoute',
  LoginRoute: 'LoginRoute',
  IntroductionRoute: 'IntroductionRoute',
  BottomBarRoute: 'BottomBarRoute',
  DetailTeamRoute: 'DetailTeamRoute',
  RouteRoute: 'RouteRoute',
  DetailRouteRoute: 'DetailRouteRoute',
  NewTeamRoute: 'NewTeamRoute',
  AccountSetupRoute: "AccountSetupRoute",
  AddMemberRoute: "AddMemberRoute",
  FriendRequestRoute: "FriendRequestRoute",
  FriendListRoute: "FriendListRoute",
  AddFriendRoute: "AddFriendRoute",
  PermissionRoute: "PermissionRoute"
};

void generateRoutes() {
  WelcomeRoute();
  LoginRoute();
  IntroductionRoute();
  BottomBarRoute();
  DetailTeamRoute();
  RouteRoute();
  DetailRouteRoute();
  NewTeamRoute();
  AccountSetupRoute();
  AddMemberRoute();
  FriendRequestRoute();
  FriendListRoute();
  AddFriendRoute();
  PermissionRoute();
}
