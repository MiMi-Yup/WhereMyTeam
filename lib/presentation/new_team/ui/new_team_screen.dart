import 'dart:io';

import 'package:configuration/route/xmd_router.dart';
import 'package:configuration/utility/constants/asset_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:where_my_team/common/widgets/m_search_component.dart';
import 'package:where_my_team/common/widgets/m_text_field.dart';
import 'package:where_my_team/common/widgets/m_user_component.dart';
import 'package:where_my_team/models/model_user.dart';
import 'package:where_my_team/presentation/new_team/cubit/new_team_cubit.dart';
import 'package:where_my_team/utils/alert_util.dart';

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
    _searchController.addListener(
        () => context.read<NewTeamCubit>().searchUser(_searchController.text));
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
        title: Text("New team"),
        actions: [
          IconButton(
              onPressed: () async {
                AlertUtil.showLoading();
                await context.read<NewTeamCubit>().createTeam();
                AlertUtil.hideLoading();
                XMDRouter.pop();
              },
              icon: Icon(Icons.done))
        ],
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () async {
              final file =
                  await _picker.pickImage(source: ImageSource.gallery);
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
                          padding: EdgeInsets.all(10),
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
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 165, 51, 255),
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(Icons.edit),
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          BlocListener<NewTeamCubit, NewTeamState>(
              listener: (context, state) {
                if (state.name != _nameController.text) {
                  _nameController.text = state.name ?? '';
                  _nameController.selection = TextSelection.collapsed(
                      offset: state.name?.length ?? 0);
                }
              },
              child: MTextField(
                controller: _nameController,
                hintText: "Name team",
              )),
          SizedBox(height: 10),
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
                      separatorBuilder: (context, index) => const SizedBox(width: 10.0),
                      itemBuilder: (context, index) => MUserComponent(
                          onPressed: () => context
                              .read<NewTeamCubit>()
                              .removeMember(state.members[index]),
                          avatar: state.members[index].avatar ?? '',
                          name: state.members[index].name ?? ''),
                    ),
              )),
          BlocListener<NewTeamCubit, NewTeamState>(
              listener: (context, state) {
                if (state.search != _searchController.text) {
                  _searchController.text = state.search ?? '';
                  _searchController.selection = TextSelection.collapsed(
                      offset: state.search?.length ?? 0);
                }
              },
              child: MTextField(
                controller: _searchController,
                hintText: "Search person",
              )),
          SizedBox(
            height: 10,
          ),
          BlocBuilder<NewTeamCubit, NewTeamState>(
              buildWhen: (previous, current) =>
                  previous.search != current.search,
              builder: (context, state) => FutureBuilder<List<ModelUser>>(
                  future: context.read<NewTeamCubit>().searchResult(),
                  builder: (context, snapshot) => snapshot.hasData
                      ? (snapshot.data!.isEmpty
                          ? const Center(
                              child: Text("Not found"),
                            )
                          : Expanded(
                              child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data?.length,
                                  itemBuilder: (context, index) =>
                                      MSearchComponent(
                                          onPressed: () {
                                            final ModelUser? selectedUser =
                                                snapshot.data?[index];
                                            if (selectedUser != null) {
                                              context
                                                  .read<NewTeamCubit>()
                                                  .addMember(selectedUser);
                                            }
                                          },
                                          avatar: snapshot
                                                  .data?[index].avatar ??
                                              'avatar/fqAueJqQeKcgMJwJFCjsC2atiHj2/image.png',
                                          name:
                                              snapshot.data?[index].name ??
                                                  '')),
                            ))
                      : const SizedBox(
                          height: 4, child: LinearProgressIndicator())))
        ],
      ),
    );
  }
}
