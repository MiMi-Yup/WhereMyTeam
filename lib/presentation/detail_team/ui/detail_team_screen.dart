import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:configuration/l10n/l10n.dart';
import 'package:configuration/route/xmd_router.dart';
import 'package:configuration/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmteam/common/widgets/m_confirm_bottom_modal.dart';
import 'package:wmteam/common/widgets/m_member_component.dart';
import 'package:wmteam/common/widgets/m_text_field_bottom_modal.dart';
import 'package:wmteam/manifest.dart';
import 'package:wmteam/models/model_member.dart';
import 'package:wmteam/models/model_team.dart';
import 'package:wmteam/models/model_user.dart';
import 'package:wmteam/presentation/add_member/add_member_route.dart';
import 'package:wmteam/presentation/bottom_bar/bottom_bar_route.dart';
import 'package:wmteam/presentation/detail_team/cubit/detail_team_cubit.dart';

class DetailTeamScreen extends StatelessWidget {
  const DetailTeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            title: BlocBuilder<DetailTeamCubit, DetailTeamState>(
                buildWhen: (previous, current) => previous.team != current.team,
                builder: (context, state) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(state.team?.name ?? ""),
                        Row(
                          children: [
                            const Icon(
                              Icons.notifications,
                              size: 16,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            FutureBuilder<int>(
                                future: state.team?.getNumberOfMembers,
                                builder: (context, snapshot) => Text(
                                      "${snapshot.data ?? 1} ${MultiLanguage.of(context).members}",
                                      style: mST10R,
                                    ))
                          ],
                        )
                      ],
                    )),
            actions: [
              IconButton(
                  onPressed: () => XMDRouter.pushNamed(
                          routerIds[AddMemberRoute]!,
                          arguments: {
                            'team': context.read<DetailTeamCubit>().team
                          }),
                  icon: const Icon(Icons.add)),
              PopupMenuButton<int>(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 0,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.logout,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(MultiLanguage.of(context).leave)
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.delete,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(MultiLanguage.of(context).delete)
                      ],
                    ),
                  )
                ],
                offset: const Offset(0, 50),
                onSelected: (index) {
                  switch (index) {
                    case 0:
                      context.read<DetailTeamCubit>().kick(null);
                      XMDRouter.popNamedAndRemoveUntil(
                          routerIds[BottomBarRoute]!);
                      break;
                    case 1:
                      context.read<DetailTeamCubit>().deleteTeam();
                      XMDRouter.popNamedAndRemoveUntil(
                          routerIds[BottomBarRoute]!);
                      break;
                    default:
                  }
                },
                icon: const Icon(Icons.more_horiz),
              )
            ]),
        body: StreamBuilder<QuerySnapshot<ModelMember>>(
            stream: context.read<DetailTeamCubit>().getStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<ModelMember> members =
                    snapshot.data!.docs.map((e) => e.data()).toList();
                return BlocBuilder<DetailTeamCubit, DetailTeamState>(
                  buildWhen: (previous, current) =>
                      previous.isAdminOfTeam != current.isAdminOfTeam,
                  builder: (context, state) => ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      itemBuilder: (context, index) => FutureBuilder<
                              ModelUser?>(
                          future: members[index].userEx,
                          builder: (context, snapshot) => snapshot.hasData
                              ? MMemberComponent(
                                  changeNicknameSlidableAction: (_) async {
                                    final result =
                                        await showTextFieldBottomModal(
                                            context,
                                            MultiLanguage.of(context).nickname,
                                            _controller,
                                            preText: members[index].nickname);
                                    if (result != null && result.isNotEmpty) {
                                      context
                                          .read<DetailTeamCubit>()
                                          .changeNickname(
                                              members[index], result);
                                    }
                                  },
                                  kickSlidableAction: (_) async {
                                    final result = await showConfirmBottomModal(
                                        context,
                                        MultiLanguage.of(context).kickMember);
                                    if (result == true) {
                                      context
                                          .read<DetailTeamCubit>()
                                          .kick(members[index]);
                                      return true;
                                    }
                                    return false;
                                  },
                                  avatar: snapshot.data?.avatar ??
                                      'avatar/fqAueJqQeKcgMJwJFCjsC2atiHj2/image.png',
                                  batteryLevel:
                                      snapshot.data?.percentBatteryDevice ??
                                          100,
                                  name: snapshot.data?.name ?? 'Doan xem',
                                  nickname:
                                      members[index].nickname ?? 'Captain meo',
                                  lastOnline: 'Online 38 mins ago',
                                  isEditable: true,
                                  isAdmin: state.isAdminOfTeam,
                                )
                              : const SizedBox.shrink()),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                      itemCount: members.length),
                );
              }
              return const LinearProgressIndicator();
            }));
  }
}
