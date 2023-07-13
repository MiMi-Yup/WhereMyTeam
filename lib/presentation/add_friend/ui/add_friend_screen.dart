import 'package:configuration/l10n/l10n.dart';
import 'package:configuration/route/xmd_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmteam/common/widgets/m_search_component.dart';
import 'package:wmteam/common/widgets/m_text_field.dart';
import 'package:wmteam/common/widgets/m_user_component.dart';
import 'package:wmteam/models/model_user.dart';
import 'package:wmteam/presentation/add_friend/cubit/add_friend_cubit.dart';
import 'package:wmteam/utils/alert_util.dart';

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({super.key});

  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(() =>
        context.read<AddFriendCubit>().searchUser(_searchController.text));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(MultiLanguage.of(context).addFriend),
        actions: [
          IconButton(
              onPressed: () async {
                AlertUtil.showLoading();
                await context.read<AddFriendCubit>().createTeam();
                AlertUtil.hideLoading();
                XMDRouter.pop();
              },
              icon: const Icon(Icons.done))
        ],
      ),
      body: Column(
        children: [
          BlocBuilder<AddFriendCubit, AddFriendState>(
              buildWhen: (previous, current) =>
                  previous.members != current.members,
              builder: (context, state) => SizedBox(
                    width: double.maxFinite,
                    height: 150,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: state.members.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 10.0),
                      itemBuilder: (context, index) => MUserComponent(
                          onPressed: () => context
                              .read<AddFriendCubit>()
                              .removeMember(state.members[index]),
                          avatar: state.members[index].avatar ?? '',
                          name: state.members[index].name ?? ''),
                    ),
                  )),
          BlocListener<AddFriendCubit, AddFriendState>(
              listener: (context, state) {
                if (state.search != _searchController.text) {
                  _searchController.text = state.search ?? '';
                  _searchController.selection = TextSelection.collapsed(
                      offset: state.search?.length ?? 0);
                }
              },
              child: MTextField(
                controller: _searchController,
                hintText: MultiLanguage.of(context).searchPerson,
              )),
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<AddFriendCubit, AddFriendState>(
              buildWhen: (previous, current) =>
                  previous.search != current.search,
              builder: (context, state) => FutureBuilder<List<ModelUser>>(
                  future: context.read<AddFriendCubit>().searchResult(),
                  builder: (context, snapshot) => snapshot.hasData
                      ? (snapshot.data!.isEmpty
                          ? Center(
                              child: Text(MultiLanguage.of(context).notFound),
                            )
                          : Expanded(
                              child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data?.length,
                                  itemBuilder: (context, index) =>
                                      MSearchComponent(
                                          onPressed: () {
                                            final ModelUser? selectedUser =
                                                snapshot.data?[index];
                                            if (selectedUser != null) {
                                              context
                                                  .read<AddFriendCubit>()
                                                  .addMember(selectedUser);
                                            }
                                          },
                                          avatar: snapshot
                                                  .data?[index].avatar ??
                                              'avatar/fqAueJqQeKcgMJwJFCjsC2atiHj2/image.png',
                                          name: snapshot.data?[index].name ??
                                              '')),
                            ))
                      : const SizedBox(
                          height: 4, child: LinearProgressIndicator())))
        ],
      ),
    );
  }
}
