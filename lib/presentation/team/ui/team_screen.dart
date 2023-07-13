import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:configuration/l10n/l10n.dart';
import 'package:configuration/route/xmd_router.dart';
import 'package:configuration/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmteam/common/widgets/m_confirm_bottom_modal.dart';
import 'package:wmteam/common/widgets/m_section.dart';
import 'package:wmteam/common/widgets/m_team_component.dart';
import 'package:wmteam/common/widgets/m_user_component.dart';
import 'package:wmteam/data/data_source/remote/cloud_storage_service.dart';
import 'package:wmteam/di/di.dart';
import 'package:wmteam/domain/repositories/user_repository.dart';
import 'package:wmteam/manifest.dart';
import 'package:wmteam/models/model_member.dart';
import 'package:wmteam/models/model_team.dart';
import 'package:wmteam/models/model_team_user.dart';
import 'package:wmteam/models/model_user.dart';
import 'package:wmteam/presentation/add_member/add_member_route.dart';
import 'package:wmteam/presentation/bottom_bar/cubit/bottom_bar_cubit.dart';
import 'package:wmteam/presentation/detail_team/detail_team_route.dart';
import 'package:wmteam/presentation/friend_list/friend_list_route.dart';
import 'package:wmteam/presentation/map/cubit/map_cubit.dart';
import 'package:wmteam/presentation/map/cubit/team_map_cubit.dart';
import 'package:wmteam/presentation/new_team/new_team_route.dart';
import 'package:wmteam/presentation/team/cubit/team_cubit.dart';
import 'package:wmteam/utils/extensions/context_extension.dart';

class TeamScreen extends StatefulWidget {
  const TeamScreen({super.key});

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  String greetingTime(MultiLanguage language) {
    final hour = DateTime.now().hour;
    if (hour <= 12) return language.goodMorning;
    if (hour <= 16) return language.goodAfternoon;
    if (hour <= 20) return language.goodEvening;
    return language.goodNight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        elevation: 0.0,
        title: FutureBuilder<ModelUser?>(
            future: getIt<UserRepository>().getCurrentUser(),
            builder: (context, snapshot) => snapshot.hasData
                ? Row(
                    children: [
                      FutureBuilder<Uint8List?>(
                          future: CloudStorageService.downloadFile(
                              snapshot.data!.avatar!),
                          builder: (context, snapshot) => snapshot.hasData
                              ? SizedBox(
                                  height: 60,
                                  width: 60,
                                  child: CircleAvatar(
                                    foregroundImage:
                                        MemoryImage(snapshot.data!, scale: 1.0),
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ))
                              : const SizedBox.shrink()),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            greetingTime(MultiLanguage.of(context)),
                            style: mST16R.copyWith(color: Colors.grey),
                          ),
                          Text(
                            //user name ??
                            MultiLanguage.of(context).username,
                            style: mST18M,
                          )
                        ],
                      ),
                    ],
                  )
                : const SizedBox.shrink()),
        actions: [
          IconButton(
              onPressed: () => XMDRouter.pushNamed(routerIds[NewTeamRoute]!),
              icon: const Icon(Icons.add)),
          IconButton(onPressed: () => null, icon: Icon(Icons.qr_code)),
          IconButton(onPressed: () => null, icon: Icon(Icons.notifications))
        ],
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          MSection(
              title: MultiLanguage.of(context).friend,
              onPressed: () => XMDRouter.pushNamed(routerIds[FriendListRoute]!),
              action: Text(MultiLanguage.of(context).more),
              headerColor: Theme.of(context).scaffoldBackgroundColor,
              titleColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
              headerPressable: true,
              content: FutureBuilder<List<ModelUser>?>(
                  future: context.read<TeamCubit>().getFriend(),
                  builder: (context, snapshot) => snapshot.hasData
                      ? SizedBox(
                          height: 120,
                          width: context.screenSize.width,
                          child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data?.length ?? 0,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 20),
                              itemBuilder: (context, index) => MUserComponent(
                                  onPressed: () {
                                    BlocProvider.of<MapCubit>(context)
                                        .focusToUser(null);
                                    BlocProvider.of<BottomBarCubit>(context)
                                        .changePage(1);
                                  },
                                  avatar: snapshot.data![index].avatar ??
                                      'avatar/fqAueJqQeKcgMJwJFCjsC2atiHj2/image.png',
                                  name: snapshot.data![index].name!)),
                        )
                      : const SizedBox.shrink())).builder(),
          MSection(
              title: MultiLanguage.of(context).yourFamily,
              headerColor: Theme.of(context).scaffoldBackgroundColor,
              titleColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
              headerPressable: true,
              action: Text(MultiLanguage.of(context).more),
              onPressed: () {
                ModelTeam? familyTeam =
                    context.read<TeamCubit>().state.familyTeam;
                if (familyTeam != null) {
                  XMDRouter.pushNamed(routerIds[DetailTeamRoute]!,
                      arguments: {'team': familyTeam});
                }
              },
              content: FutureBuilder<Stream<QuerySnapshot<ModelMember>>?>(
                  future: context.read<TeamCubit>().getMembersOfPrimaryTeam(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final familyTeam =
                          context.read<TeamCubit>().state.familyTeam;
                      if (familyTeam != null) {
                        BlocProvider.of<TeamMapCubit>(context)
                            .changeTeam(familyTeam);
                        BlocProvider.of<MapCubit>(context)
                            .changeTeam(familyTeam);
                      }
                      return SizedBox(
                        height: 120,
                        width: context.screenSize.width,
                        child: StreamBuilder<QuerySnapshot<ModelMember>>(
                          stream: snapshot.data,
                          builder: (context, snapshot) {
                            final members = snapshot.data?.docs
                                .map((e) => e.data())
                                .toList();
                            if (members == null || members.isEmpty) {
                              return const SizedBox.shrink();
                            }
                            return FutureBuilder<List<ModelUser?>>(
                                future:
                                    Future.wait(members.map((e) => e.userEx)),
                                builder: (context, snapshot) => snapshot.hasData &&
                                        (snapshot.data?.length ?? 0) > 0
                                    ? ListView.separated(
                                        physics: const BouncingScrollPhysics(),
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshot.data!.length,
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(width: 20),
                                        itemBuilder: (context, index) =>
                                            MUserComponent(
                                                avatar: snapshot
                                                        .data?[index]?.avatar ??
                                                    "",
                                                name: snapshot
                                                        .data?[index]?.name ??
                                                    ""))
                                    : const LinearProgressIndicator());
                          },
                        ),
                      );
                    } else {
                      return const LinearProgressIndicator();
                    }
                  })).builder(),
          MSection(
              title: MultiLanguage.of(context).teams,
              headerColor: Theme.of(context).scaffoldBackgroundColor,
              titleColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
              content: StreamBuilder<QuerySnapshot<ModelTeamUser>>(
                stream: context.read<TeamCubit>().getStreamTeam(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<ModelTeamUser>? teams =
                        snapshot.data?.docs.map((e) => e.data()).toList();
                    if (teams == null || teams.length == 0) {
                      return Center(
                          child: Text(MultiLanguage.of(context).noTeams));
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
                                    const SizedBox(width: 20),
                                itemBuilder: (context, index) => MTeamComponent(
                                    viewInMapSlidableAction: (_) {
                                      BlocProvider.of<BottomBarCubit>(context)
                                          .changePage(1);
                                      BlocProvider.of<TeamMapCubit>(context)
                                          .changeTeam(models[index].team);
                                      BlocProvider.of<MapCubit>(context)
                                          .changeTeam(models[index].team);
                                    },
                                    inviteSlidableAction:
                                        (_) =>
                                            XMDRouter.pushNamed(
                                                routerIds[AddMemberRoute]!,
                                                arguments: {
                                                  'team': models[index].team
                                                }),
                                    leaveSlidableAction: (_) async {
                                      bool? result =
                                          await showConfirmBottomModal(
                                              context,
                                              MultiLanguage.of(context)
                                                  .leaveTeam);
                                      if (result == true) {
                                        await context
                                            .read<TeamCubit>()
                                            .leaveTeam(models[index].team);
                                      }
                                      return result ?? false;
                                    },
                                    avatar: models[index].team.avatar ??
                                        'avatar/fqAueJqQeKcgMJwJFCjsC2atiHj2/image.png',
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
      ),
    );
  }
}

class TeamModel {
  final ModelTeam team;
  final int count;

  const TeamModel({required this.team, required this.count});
}
