import 'package:configuration/l10n/l10n.dart';
import 'package:configuration/route/xmd_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmteam/common/widgets/m_friend_component.dart';
import 'package:wmteam/manifest.dart';
import 'package:wmteam/presentation/add_friend/add_friend_route.dart';
import 'package:wmteam/presentation/friend_list/cubit/friend_list_cubit.dart';

class FriendListScreen extends StatelessWidget {
  const FriendListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FriendListCubit>().init();
    return Scaffold(
        appBar: AppBar(
          title: Text(MultiLanguage.of(context).friend),
          elevation: 0.0,
          actions: [
            IconButton(
                onPressed: () =>
                    XMDRouter.pushNamed(routerIds[AddFriendRoute]!),
                icon: const Icon(Icons.add))
          ],
        ),
        body: BlocBuilder<FriendListCubit, FriendListState>(
            buildWhen: (previous, current) =>
                previous.members != current.members,
            builder: (context, state) => ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => MFriendComponent(
                      avatar: state.members[index].avatar ??
                          'avatar/fqAueJqQeKcgMJwJFCjsC2atiHj2/image.png',
                      name: state.members[index].name!,
                      onUnFriend: () => context
                          .read<FriendListCubit>()
                          .unFriend(state.members[index]),
                    ),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10.0,
                    ),
                itemCount: state.members.length)));
  }
}
