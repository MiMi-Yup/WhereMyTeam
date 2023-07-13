import 'dart:io';

import 'package:configuration/l10n/l10n.dart';
import 'package:configuration/route/xmd_router.dart';
import 'package:configuration/utility/constants/asset_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wmteam/common/widgets/m_search_component.dart';
import 'package:wmteam/common/widgets/m_text_field.dart';
import 'package:wmteam/common/widgets/m_user_component.dart';
import 'package:wmteam/models/model_user.dart';
import 'package:wmteam/presentation/new_team/cubit/new_team_cubit.dart';
import 'package:wmteam/utils/alert_util.dart';

class NewTeamScreen extends StatefulWidget {
  const NewTeamScreen({super.key});

  @override
  State<NewTeamScreen> createState() => _NewTeamScreenState();
}

class _NewTeamScreenState extends State<NewTeamScreen> {
  late TextEditingController _nameController;
  late TextEditingController _searchController;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _searchController = TextEditingController();

    _nameController.addListener(
        () => context.read<NewTeamCubit>().changeName(_nameController.text));

    context.read<NewTeamCubit>().init();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(MultiLanguage.of(context).newTeam),
        actions: [
          IconButton(
              onPressed: () async {
                AlertUtil.showLoading();
                await context.read<NewTeamCubit>().createTeam();
                AlertUtil.hideLoading();
                XMDRouter.pop();
              },
              icon: const Icon(Icons.done))
        ],
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () async {
              final file = await _picker.pickImage(source: ImageSource.gallery);
              if (file != null) {
                context.read<NewTeamCubit>().changeAvatar(file.path);
              }
            },
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                BlocBuilder<NewTeamCubit, NewTeamState>(
                    buildWhen: (previous, current) =>
                        previous.avatar != current.avatar,
                    builder: (context, state) => Container(
                          height: 100,
                          width: 100,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: state.avatar == null
                                      ? const AssetImage(mAApple)
                                      : FileImage(File(state.avatar!))
                                          as ImageProvider),
                              color: Colors.grey),
                        )),
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 165, 51, 255),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.edit),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          BlocListener<NewTeamCubit, NewTeamState>(
              listener: (context, state) {
                if (state.name != _nameController.text) {
                  _nameController.text = state.name ?? '';
                  _nameController.selection =
                      TextSelection.collapsed(offset: state.name?.length ?? 0);
                }
              },
              child: MTextField(
                controller: _nameController,
                hintText: MultiLanguage.of(context).nameTeam,
              )),
          const SizedBox(height: 10),
          BlocBuilder<NewTeamCubit, NewTeamState>(
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
                              .read<NewTeamCubit>()
                              .removeMember(state.members[index]),
                          avatar: state.members[index].avatar ?? '',
                          name: state.members[index].name ?? ''),
                    ),
                  )),
          BlocBuilder<NewTeamCubit, NewTeamState>(
              buildWhen: (previous, current) =>
                  previous.friends != current.friends,
              builder: (context, state) => state.friends.isEmpty
                  ? Center(
                      child: Text(MultiLanguage.of(context).notFound),
                    )
                  : Expanded(
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.friends.length,
                          itemBuilder: (context, index) => MSearchComponent(
                              onPressed: () {
                                final ModelUser? selectedUser =
                                    state.friends[index];
                                if (selectedUser != null) {
                                  context
                                      .read<NewTeamCubit>()
                                      .addMember(selectedUser);
                                }
                              },
                              avatar: state.friends[index].avatar ??
                                  'avatar/fqAueJqQeKcgMJwJFCjsC2atiHj2/image.png',
                              name: state.friends[index].name ?? '')),
                    ))
        ],
      ),
    );
  }
}
