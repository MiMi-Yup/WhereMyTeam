import 'package:configuration/l10n/l10n.dart';
import 'package:configuration/route/xmd_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:where_my_team/common/widgets/m_search_component.dart';
import 'package:where_my_team/common/widgets/m_text_field.dart';
import 'package:where_my_team/common/widgets/m_user_component.dart';
import 'package:where_my_team/models/model_user.dart';
import 'package:where_my_team/presentation/add_member/cubit/add_member_cubit.dart';
import 'package:where_my_team/utils/alert_util.dart';

class AddMemberScreen extends StatefulWidget {
  const AddMemberScreen({super.key});

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  late TextEditingController _searchController;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();

    _searchController.addListener(() =>
        context.read<AddMemberCubit>().searchUser(_searchController.text));
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
        title: Text(MultiLanguage.of(context).addMember),
        actions: [
          IconButton(
              onPressed: () async {
                AlertUtil.showLoading();
                await context.read<AddMemberCubit>().createTeam();
                AlertUtil.hideLoading();
                XMDRouter.pop();
              },
              icon: Icon(Icons.done))
        ],
      ),
      body: FutureBuilder<bool>(
          future: context.read<AddMemberCubit>().init(),
          initialData: false,
          builder: (context, snapshot) => snapshot.hasData
              ? Column(
                  children: [
                    BlocBuilder<AddMemberCubit, AddMemberState>(
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
                                        .read<AddMemberCubit>()
                                        .removeMember(state.members[index]),
                                    avatar: state.members[index].avatar ?? '',
                                    name: state.members[index].name ?? ''),
                              ),
                            )),
                    BlocListener<AddMemberCubit, AddMemberState>(
                        listener: (context, state) {
                          if (state.search != _searchController.text) {
                            _searchController.text = state.search ?? '';
                            _searchController.selection =
                                TextSelection.collapsed(
                                    offset: state.search?.length ?? 0);
                          }
                        },
                        child: MTextField(
                          controller: _searchController,
                          hintText: MultiLanguage.of(context).searchPerson,
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<AddMemberCubit, AddMemberState>(
                        buildWhen: (previous, current) =>
                            previous.search != current.search,
                        builder: (context, state) => FutureBuilder<
                                List<ModelUser>>(
                            future:
                                context.read<AddMemberCubit>().searchResult(),
                            builder: (context, snapshot) => snapshot.hasData
                                ? (snapshot.data!.isEmpty
                                    ? Center(
                                        child: Text(
                                            MultiLanguage.of(context).notFound),
                                      )
                                    : Expanded(
                                        child: ListView.builder(
                                            physics: BouncingScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: snapshot.data?.length,
                                            itemBuilder: (context, index) =>
                                                MSearchComponent(
                                                    onPressed: () {
                                                      final ModelUser?
                                                          selectedUser =
                                                          snapshot.data?[index];
                                                      if (selectedUser !=
                                                          null) {
                                                        context
                                                            .read<
                                                                AddMemberCubit>()
                                                            .addMember(
                                                                selectedUser);
                                                      }
                                                    },
                                                    avatar: snapshot
                                                            .data?[index]
                                                            .avatar ??
                                                        'avatar/fqAueJqQeKcgMJwJFCjsC2atiHj2/image.png',
                                                    name: snapshot.data?[index]
                                                            .name ??
                                                        '')),
                                      ))
                                : const SizedBox(
                                    height: 4,
                                    child: LinearProgressIndicator())))
                  ],
                )
              : const LinearProgressIndicator()),
    );
  }
}
