import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:configuration/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_my_team/common/widgets/m_member_component.dart';
import 'package:where_my_team/models/model_member.dart';
import 'package:where_my_team/models/model_team.dart';
import 'package:where_my_team/models/model_user.dart';
import 'package:where_my_team/presentation/detail_team/cubit/detail_team_cubit.dart';

class DetailTeamScreen extends StatelessWidget {
  const DetailTeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            title: FutureBuilder(
                future: context.read<DetailTeamCubit>().getFullInfo(),
                builder: (context, snapshot) => snapshot.hasData
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(snapshot.data?.name ?? ""),
                          Row(
                            children: [
                              Icon(
                                Icons.notifications,
                                size: 16,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              FutureBuilder<int>(
                                  future: snapshot.data?.getNumberOfMembers,
                                  builder: (context, snapshot) => Text(
                                        "${snapshot.data ?? 1} members",
                                        style: mST10R,
                                      ))
                            ],
                          )
                        ],
                      )
                    : SizedBox.shrink()),
            actions: [
              IconButton(onPressed: () => null, icon: Icon(Icons.add)),
              PopupMenuButton<int>(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 0,
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text("Leave")
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text("Delete team")
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Row(
                      children: [
                        Icon(
                          Icons.rule,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text("Change role")
                      ],
                    ),
                  )
                ],
                offset: Offset(0, 50),
                onSelected: null,
                icon: Icon(Icons.more_horiz),
              )
            ]),
        body: StreamBuilder<QuerySnapshot<ModelMember>>(
            stream: context.read<DetailTeamCubit>().getStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<ModelMember> members =
                    snapshot.data!.docs.map((e) => e.data()).toList();
                return ListView.separated(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(left: 10, right: 10),
                    itemBuilder: (context, index) => FutureBuilder<ModelUser?>(
                        future: members[index].userEx,
                        builder: (context, snapshot) => snapshot.hasData
                            ? MMemberComponent(
                                avatar: snapshot.data?.avatar ??
                                    'https://www.rd.com/wp-content/uploads/2020/11/redo-cat-meme6.jpg?w=1414',
                                batteryLevel:
                                    snapshot.data?.percentBatteryDevice ?? 100,
                                name: snapshot.data?.name ?? 'Doan xem',
                                nickname:
                                    members[index].nickname ?? 'Captain meo',
                                lastOnline: 'Online 38 mins ago',
                                isEditable: true,
                                isAdmin: true,
                              )
                            : const SizedBox.shrink()),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                    itemCount: members.length);
              }
              return const LinearProgressIndicator();
            }));
  }
}
