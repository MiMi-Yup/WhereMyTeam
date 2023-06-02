import 'dart:io';

import 'package:configuration/l10n/l10n.dart';
import 'package:configuration/route/xmd_router.dart';
import 'package:configuration/style/style.dart';
import 'package:configuration/utility/constants/asset_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_my_team/common/widgets/m_primary_button.dart';
import 'package:where_my_team/common/widgets/m_text_field.dart';
import 'package:where_my_team/models/model_user.dart';
import 'package:where_my_team/presentation/auth/account_setup/cubit/account_setup_cubit.dart';
import 'package:where_my_team/utils/alert_util.dart';
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
                          builder: (context, state) => Container(
                                height: 100,
                                width: 100,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: state.avatar == null
                                            ? const AssetImage(mAGoogle)
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
                MTextField(
                  controller: _nameController,
                  hintText: MultiLanguage.of(context).darkTheme,
                  onChanged: (value) =>
                      context.read<AccountSetupCubit>().changeName(value),
                ),
                SizedBox(height: 10),
                MTextField(
                  controller: _phoneController,
                  hintText: MultiLanguage.of(context).darkTheme,
                  onChanged: (value) => context
                      .read<AccountSetupCubit>()
                      .changePhoneNumber(value),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MPrimaryButton(
                text: MultiLanguage.of(context).cancel,
                onPressed: () async {
                  final state = context.read<AccountSetupCubit>().state;
                  if (state.isFormValid) {
                    XMDRouter.pop(
                        result: ModelUser(
                            id: null,
                            email: null,
                            name: state.fullname,
                            phoneNumber: state.phoneNumber,
                            avatar: state.avatar));
                  } else {
                    AlertUtil.showToast('Invalid form');
                  }
                }),
          )
        ],
      ),
    );
  }
}
