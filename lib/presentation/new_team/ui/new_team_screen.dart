import 'package:configuration/route/xmd_router.dart';
import 'package:configuration/style/style.dart';
import 'package:configuration/utility/constants/asset_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_my_team/common/widgets/m_search_component.dart';
import 'package:where_my_team/common/widgets/m_text_field.dart';
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
      body: Padding(
        padding: EdgeInsets.all(mPaddingNormal),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: AssetImage(mAApple)),
                      color: Colors.grey),
                ),
                Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 165, 51, 255),
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(Icons.edit),
                )
              ],
            ),
            SizedBox(height: 10),
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
                  hintText: "Name team",
                )),
            SizedBox(height: 10),
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
              height: 80,
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
                                    itemBuilder: (context, index) => MSearchComponent(
                                        networkImage: snapshot
                                                .data?[index].avatar ??
                                            'https://www.rd.com/wp-content/uploads/2020/11/redo-cat-meme6.jpg?w=1414',
                                        name: snapshot.data?[index].name ?? '')),
                              ))
                        : const SizedBox(
                            height: 4, child: LinearProgressIndicator())))
          ],
        ),
      ),
    );
  }
}
