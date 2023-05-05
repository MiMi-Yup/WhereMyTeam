import 'package:configuration/style/style.dart';
import 'package:flutter/material.dart';
import 'package:where_my_team/common/widgets/m_member_component.dart';

class DetailTeamScreen extends StatelessWidget {
  const DetailTeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Con meo den"),
                Row(
                  children: [
                    Icon(
                      Icons.notifications,
                      size: 16,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      "No receive notification",
                      style: mST10R,
                    )
                  ],
                )
              ],
            ),
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
        body: ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(left: 10, right: 10),
            itemBuilder: (context, index) => MMemberComponent(
                  avatar:
                      'https://www.rd.com/wp-content/uploads/2020/11/redo-cat-meme6.jpg?w=1414',
                  batteryLevel: 79,
                  name: 'Doan xem',
                  nickname: 'Captain meo',
                  lastOnline: 'Online 38 mins ago',
                  isEditable: true,
                  isAdmin: true,
                ),
            separatorBuilder: (context, index) => SizedBox(
                  height: 10,
                ),
            itemCount: 10));
  }
}
