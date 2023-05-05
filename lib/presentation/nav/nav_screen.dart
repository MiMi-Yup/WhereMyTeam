import 'package:flutter/material.dart';
import 'package:where_my_team/common/widgets/m_bottom_app_bar.dart';
import 'package:where_my_team/presentation/map/map_page.dart';
import 'package:where_my_team/presentation/team/team_page.dart';

enum EPage { team, map, profile }

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final Map<EPage, int?> _mapPage = <EPage, int?>{
    EPage.team: 0,
    EPage.map: 1,
    EPage.profile: 2
  };

  late TabController _tabController;

  bool keepAlive = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        initialIndex: 0,
        length: 3,
        animationDuration: const Duration(milliseconds: 250),
        vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void toPage(int page) {
    if (_mapPage.containsValue(page)) {
      _tabController.animateTo(page,
          curve: Curves.linear, duration: const Duration(milliseconds: 250));
    }
  }

  late final Map<int, ItemNavModal?> _navActions = <int, ItemNavModal?>{
    0: ItemNavModal(icon: Icons.group, label: "Team", index: 0, toPage: toPage),
    1: ItemNavModal(icon: Icons.map, label: "Map", index: 1, toPage: toPage),
    2: ItemNavModal(
        icon: Icons.person, label: "Profile", index: 2, toPage: toPage),
  };

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      // extendBody: true,
      bottomNavigationBar: MBottomAppBar(
              navActions: _navActions, currentIndex: _tabController.index)
          .builder(),
      body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: [
            const TeamPage(),
            const MapPage(),
            const Placeholder()
          ]),
    );
  }

  @override
  bool get wantKeepAlive => keepAlive;
}
