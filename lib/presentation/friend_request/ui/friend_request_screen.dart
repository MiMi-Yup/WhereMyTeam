import 'package:configuration/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmteam/common/widgets/m_user_request_component.dart';
import 'package:wmteam/presentation/friend_request/cubit/friend_request_cubit.dart';

class FriendRequestScreen extends StatelessWidget {
  const FriendRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FriendRequestCubit>().init();
    return Scaffold(
        appBar: AppBar(
          title: Text(MultiLanguage.of(context).friendRequest),
          elevation: 0.0,
        ),
        body: BlocBuilder<FriendRequestCubit, FriendRequestState>(
            buildWhen: (previous, current) =>
                previous.members != current.members,
            builder: (context, state) => ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => MUserRequestComponent(
                      avatar: state.members[index].avatar ??
                          'avatar/fqAueJqQeKcgMJwJFCjsC2atiHj2/image.png',
                      name: state.members[index].name!,
                      onAccept: () => context
                          .read<FriendRequestCubit>()
                          .accept(state.members[index]),
                      onDenied: () => context
                          .read<FriendRequestCubit>()
                          .denied(state.members[index]),
                    ),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10.0,
                    ),
                itemCount: state.members.length)));
  }
}
