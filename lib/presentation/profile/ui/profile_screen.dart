import 'dart:typed_data';

import 'package:configuration/l10n/l10n.dart';
import 'package:configuration/route/xmd_router.dart';
import 'package:configuration/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmteam/common/widgets/m_button_setting.dart';
import 'package:wmteam/common/widgets/m_confirm_bottom_modal.dart';
import 'package:wmteam/di/di.dart';
import 'package:wmteam/domain/repositories/user_repository.dart';
import 'package:wmteam/domain/use_cases/login_page_usecases.dart';
import 'package:wmteam/manifest.dart';
import 'package:wmteam/models/model_user.dart';
import 'package:wmteam/presentation/auth/account_setup/account_setup_route.dart';
import 'package:wmteam/presentation/auth/login/login_route.dart';
import 'package:get/get.dart';
import 'package:wmteam/presentation/friend_request/friend_request_route.dart';
import 'package:wmteam/presentation/profile/cubit/profile_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(MultiLanguage.of(context).profile),
            elevation: 0.0,
            actions: [
              PopupMenuButton<int>(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 0,
                    child: Row(
                      children: [
                        const Icon(Icons.logout),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(MultiLanguage.of(context).logout)
                      ],
                    ),
                  )
                ],
                offset: const Offset(0, 50),
                onSelected: (index) async {
                  switch (index) {
                    case 0:
                      bool? result = await showConfirmBottomModal(
                          context, MultiLanguage.of(context).confirmLogout);
                      if (result == true) {
                        await getIt<LoginUseCases>().signOut();
                        XMDRouter.pushNamedAndRemoveUntil(
                            routerIds[LoginRoute]!);
                      }
                      break;
                    default:
                      break;
                  }
                },
                icon: const Icon(Icons.more_horiz),
              )
            ]),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: 75,
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        SizedBox(
                          height: 75,
                          width: 75,
                          child: FutureBuilder<Uint8List?>(
                              future: context
                                  .read<ProfileCubit>()
                                  .userUseCases
                                  .getAvatar(),
                              builder: (context, snapshot) => snapshot.hasData
                                  ? CircleAvatar(
                                      foregroundImage: MemoryImage(
                                          snapshot.data!,
                                          scale: 1.0))
                                  : const SizedBox.shrink()),
                        ),
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 165, 51, 255),
                              borderRadius: BorderRadius.circular(4)),
                          child: const Icon(
                            Icons.edit,
                            size: 16,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: FutureBuilder<ModelUser?>(
                          future: context
                              .read<ProfileCubit>()
                              .userUseCases
                              .unitOfWork
                              .user
                              .getCurrentUser(),
                          builder: (context, snapshot) => snapshot.hasData
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      snapshot.data?.name ?? '',
                                      style: mST20M,
                                    ),
                                    Text(
                                      snapshot.data?.email ?? '',
                                      style: mST16M,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                )
                              : const SizedBox.shrink()),
                    ),
                  ],
                ),
              ),
              MButtonSetting(
                title: MultiLanguage.of(context).editProfile,
                icon: const Icon(Icons.person_outline),
                onPressed: (_) async {
                  final result = await XMDRouter.pushNamedForResult(
                      routerIds[AccountSetupRoute]!,
                      arguments: {
                        'model': await getIt<UserRepository>().getCurrentUser()
                      });
                  if (result is ModelUser) {
                    context.read<ProfileCubit>().updateProfile(result);
                  }
                },
              ),
              FutureBuilder<int>(
                future: context.read<ProfileCubit>().getCountRequestsFriend(),
                initialData: 0,
                builder: (context, snapshot) => MButtonSetting(
                  title: MultiLanguage.of(context).friendRequest,
                  subTitlte:
                      '${snapshot.data} ${MultiLanguage.of(context).request}',
                  icon: const Icon(Icons.request_quote),
                  onPressed: (_) => XMDRouter.pushNamedForResult(
                      routerIds[FriendRequestRoute]!),
                ),
              ),
              MButtonSetting(
                title: MultiLanguage.of(context).language,
                icon: const Icon(Icons.language),
                onPressed: (_) => showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(10.0))),
                    builder: (_) {
                      final locales = MultiLanguage.delegate.supportedLocales;
                      final currentLocale = Localizations.localeOf(context);
                      return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: locales.length,
                          itemBuilder: (_, index) {
                            final itemLocale = locales[index];
                            return ListTile(
                              onTap: () {
                                XMDRouter.pop();
                                context
                                    .read<ProfileCubit>()
                                    .userUseCases
                                    .setLanguage(itemLocale);
                                Get.updateLocale(itemLocale);
                              },
                              trailing: locales[index].languageCode ==
                                      currentLocale.languageCode
                                  ? const Icon(Icons.check)
                                  : null,
                              title: Localizations.override(
                                context: context,
                                locale: itemLocale,
                                child: Builder(
                                    builder: (context) => Text(
                                        MultiLanguage.of(context).languageName,
                                        style: mST16M)),
                              ),
                            );
                          });
                    }),
              ),
              MButtonSetting(
                title: MultiLanguage.of(context).darkTheme,
                icon: const Icon(Icons.brightness_2),
                isSwitch: true,
                initState: Theme.of(context).brightness == Brightness.dark,
                onPressed: (p0) {
                  final mode = p0 == true ? ThemeMode.dark : ThemeMode.light;
                  context.read<ProfileCubit>().userUseCases.setTheme(mode);
                  Get.changeThemeMode(mode);
                },
              ),
              MButtonSetting(
                title: MultiLanguage.of(context).helpCenter,
                icon: const Icon(Icons.help_center),
              ),
            ],
          ),
        ));
  }
}
