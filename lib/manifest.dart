import 'package:where_my_team/presentation/auth/login/login_page_route.dart';
import 'package:where_my_team/presentation/start_page/start_page_route.dart';

import 'presentation/home_page/home_page_route.dart';

const routerIds = {
  HomePageRoute: 'HomePageRoute',
  StartPageRoute: 'StartPageRoute',
  LoginPageRoute: 'LoginPageRoute'
};

void generateRoutes() {
  HomePageRoute();
  StartPageRoute();
  LoginPageRoute();
}