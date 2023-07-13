import 'dart:io';
import 'dart:typed_data';

import 'package:configuration/l10n/l10n.dart';
import 'package:configuration/route/xmd_router.dart';
import 'package:configuration/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmteam/common/widgets/m_primary_button.dart';
import 'package:wmteam/common/widgets/m_text_field.dart';
import 'package:wmteam/data/data_source/remote/cloud_storage_service.dart';
import 'package:wmteam/models/model_user.dart';
import 'package:wmteam/presentation/auth/account_setup/cubit/account_setup_cubit.dart';
import 'package:wmteam/utils/alert_util.dart';
import 'package:image_picker/image_picker.dart';

class AccountSetupScreen extends StatelessWidget {
  AccountSetupScreen({super.key});

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final TextEditingController _nameController = TextEditingController(
        text: BlocProvider.of<AccountSetupCubit>(context).state.fullname);
    final TextEditingController _phoneController = TextEditingController(
        text: BlocProvider.of<AccountSetupCubit>(context).state.phoneNumber);
    return Scaffold(
      appBar: AppBar(
          title: Text(
            MultiLanguage.of(context).confirm,
          ),
          elevation: 0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.all(mPadding),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    final file =
                        await _picker.pickImage(source: ImageSource.gallery);
                    if (file != null) {
                      context.read<AccountSetupCubit>().changeAvatar(file.path);
                    }
                  },
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      BlocBuilder<AccountSetupCubit, AccountSetupState>(
                          buildWhen: (previous, current) =>
                              previous.avatar != current.avatar,
                          builder: (context, state) => state.avatar == null
                              ? SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: state.signUp
                                      ? CircleAvatar(
                                          foregroundImage: NetworkImage(
                                              state.initAvatar,
                                              scale: 1.0))
                                      : FutureBuilder<Uint8List?>(
                                          future:
                                              CloudStorageService.downloadFile(
                                                  state.initAvatar),
                                          builder: (context, snapshot) =>
                                              snapshot.hasData
                                                  ? CircleAvatar(
                                                      foregroundImage:
                                                          MemoryImage(
                                                              snapshot.data!,
                                                              scale: 1.0))
                                                  : const SizedBox.shrink()),
                                )
                              : Container(
                                  height: 100,
                                  width: 100,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image:
                                              FileImage(File(state.avatar!))),
                                      color: Colors.grey),
                                )),
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 165, 51, 255),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(Icons.edit),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                MTextField(
                  controller: _nameController,
                  hintText: MultiLanguage.of(context).nickname,
                  onChanged: (value) =>
                      context.read<AccountSetupCubit>().changeName(value),
                ),
                const SizedBox(height: 10),
                MTextField(
                  controller: _phoneController,
                  hintText: MultiLanguage.of(context).phoneNumber,
                  onChanged: (value) => context
                      .read<AccountSetupCubit>()
                      .changePhoneNumber(value),
                ),
              ],
            ),
          ),
          BlocListener<AccountSetupCubit, AccountSetupState>(
            listener: (context, state) {
              switch (state.state) {
                case Status.success:
                  AlertUtil.hideLoading();
                  XMDRouter.pop(
                      result: ModelUser(
                          id: null,
                          email: null,
                          avatar: state.avatar,
                          phoneNumber: state.phoneNumber,
                          name: state.fullname));
                  break;
                case Status.error:
                  AlertUtil.hideLoading();
                  break;
                default:
                  break;
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: MPrimaryButton(
                  text: MultiLanguage.of(context).complete,
                  onPressed: () async {
                    final state = context.read<AccountSetupCubit>().state;
                    if (state.isFormValid) {
                      AlertUtil.showLoading();
                      await context.read<AccountSetupCubit>().updateProfile();
                    } else {
                      AlertUtil.showToast(
                          MultiLanguage.of(context).missingSomething);
                    }
                  }),
            ),
          )
        ],
      ),
    );
  }
}
