import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:configuration/route/xmd_router.dart';
import 'package:configuration/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_my_team/common/widgets/m_section.dart';
import 'package:where_my_team/common/widgets/m_team_component.dart';
import 'package:where_my_team/manifest.dart';
import 'package:where_my_team/models/model_team.dart';
import 'package:where_my_team/models/model_team_user.dart';
import 'package:where_my_team/presentation/detail_team/detail_team_route.dart';
import 'package:where_my_team/presentation/new_team/new_team_route.dart';
import 'package:where_my_team/presentation/team/cubit/team_cubit.dart';
import 'package:where_my_team/utils/extensions/context_extension.dart';

class TeamScreen extends StatefulWidget {
  const TeamScreen({super.key});

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0)),
                gradient: LinearGradient(
                    colors: [
                      const Color(0xFF3366FF),
                      const Color(0xFF00CCFF),
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: GestureDetector(
                    onTap: () => null,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.pink.withAlpha(120)),
                      child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://www.rd.com/wp-content/uploads/2020/11/redo-cat-meme6.jpg?w=1414',
                              scale: 1.0)),
                    ),
                  ),
                  title: Text("Andrew"),
                  actions: [
                    IconButton(
                        onPressed: () =>
                            XMDRouter.pushNamed(routerIds[NewTeamRoute]!),
                        icon: Icon(Icons.add)),
                    IconButton(
                        onPressed: () => null, icon: Icon(Icons.qr_code)),
                    IconButton(
                        onPressed: () => null, icon: Icon(Icons.notifications))
                  ])),
          Expanded(
              child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              MSection(
                  title: "People Nearby",
                  titleColor: Colors.black,
                  headerColor: Colors.white,
                  headerPressable: false,
                  content: SizedBox(
                    height: 120,
                    width: context.screenSize.width,
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.only(left: 10, right: 10),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 20),
                        itemBuilder: (context, index) => GestureDetector(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10.0),
                                    margin: const EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.primaries[Random()
                                                .nextInt(
                                                    Colors.primaries.length)]
                                            .withAlpha(120)),
                                    child: Image(
                                        height: 40.0,
                                        width: 40.0,
                                        image: NetworkImage(
                                            'https://www.vhv.rs/dpng/f/429-4290135_moon-emoji-png.png',
                                            scale: 1.0)),
                                  ),
                                  Text("Rachel", style: mST16R),
                                  Text(
                                    "2 km",
                                    style: mST14R.copyWith(color: Colors.grey),
                                  )
                                ],
                              ),
                            )),
                  )).builder(),
              MSection(
                  title: "Your family",
                  titleColor: Colors.black,
                  headerColor: Colors.white,
                  headerPressable: false,
                  action: Text('more'),
                  onPressed: () => print('more family'),
                  content: SizedBox(
                    height: 120,
                    width: context.screenSize.width,
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.only(left: 10, right: 10),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 20),
                        itemBuilder: (context, index) => GestureDetector(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10.0),
                                    margin: const EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.primaries[Random()
                                                .nextInt(
                                                    Colors.primaries.length)]
                                            .withAlpha(120)),
                                    child: Image(
                                        height: 40.0,
                                        width: 40.0,
                                        image: NetworkImage(
                                            'https://www.vhv.rs/dpng/f/429-4290135_moon-emoji-png.png',
                                            scale: 1.0)),
                                  ),
                                  Text("Rachel", style: mST16R),
                                  Text(
                                    "Moving...",
                                    style: mST14R.copyWith(color: Colors.grey),
                                  )
                                ],
                              ),
                            )),
                  )).builder(),
              MSection(
                  title: "Teams",
                  titleColor: Colors.black,
                  headerColor: Colors.white,
                  content: StreamBuilder<QuerySnapshot<ModelTeamUser>>(
                    stream: context.read<TeamCubit>().getStreamTeam(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<ModelTeamUser>? teams =
                            snapshot.data?.docs.map((e) => e.data()).toList();
                        if (teams == null || teams.length == 0) {
                          return const Center(child: Text("No teams"));
                        }

                        return FutureBuilder<List<TeamModel?>>(
                            future: Future.wait(teams.map((e) async {
                              final team = await e.teamEx;
                              final count = await team?.getNumberOfMembers;
                              return team != null && count != null
                                  ? TeamModel(team: team, count: count)
                                  : null;
                            }).toList()),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<TeamModel> models = snapshot.data!
                                    .where((element) => element != null)
                                    .cast<TeamModel>()
                                    .toList();
                                return ListView.separated(
                                    physics: const BouncingScrollPhysics(),
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    shrinkWrap: true,
                                    itemCount: models.length,
                                    separatorBuilder: (context, index) =>
                                        SizedBox(width: 20),
                                    itemBuilder: (context, index) => MTeamComponent(
                                        avatar: models[index].team.avatar ??
                                            'https://www.rd.com/wp-content/uploads/2020/11/redo-cat-meme6.jpg?w=1414',
                                        name: models[index].team.name ?? '',
                                        members: models[index].count,
                                        isEditable: true,
                                        onTap: () => XMDRouter.pushNamed(
                                                routerIds[DetailTeamRoute]!,
                                                arguments: {
                                                  'team': models[index].team
                                                })));
                              }
                              return const LinearProgressIndicator();
                            });
                      }
                      return const LinearProgressIndicator();
                    },
                  )).builder(),
            ],
          ))
        ],
      ),
    );
  }
}

class TeamModel {
  final ModelTeam team;
  final int count;

  const TeamModel({required this.team, required this.count});
}
