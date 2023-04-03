import 'package:configuration/l10n/l10n.dart';
import 'package:configuration/route/xmd_router.dart';
import 'package:configuration/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_my_team/common/widgets/m_text_field.dart';
import 'package:where_my_team/presentation/auth/login/cubit/login_page_cubit.dart';
import 'package:where_my_team/utils/alert_util.dart';
import 'package:where_my_team/utils/extensions/context_extension.dart';

class LoginPageScreen extends StatelessWidget {
  const LoginPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset("assets/img/login_image.jpg"),
      bottomSheet: SizedBox(
        height: context.screenSize.height * 0.6,
        width: double.maxFinite,
        child: Padding(
          padding: EdgeInsets.all(mPaddingLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //login text
              Text(
                MultiLanguage.of(context).cancelled,
                style: textTitleStyleH1,
              ),
              SizedBox(height: mSpacing * 5),
              //user name
              MTextField(
                onChanged: (value) =>
                    context.read<LoginPageCubit>().emailChanged(value),
                hintText: MultiLanguage.of(context).connectionProblemDesc,
                preIcon: Icons.person,
              ),
              SizedBox(height: mSpacing * 2),
              //password
              MTextField(
                onChanged: (value) =>
                    context.read<LoginPageCubit>().passwordChanged(value),
                obscureText: true,
                hintText: MultiLanguage.of(context).databaseException,
                preIcon: Icons.lock,
              ),
              SizedBox(height: mSpacing * 5),
              //login button
              BlocConsumer<LoginPageCubit, LoginPageState>(
                listener: (context, state) {
                  if (state.status == LoginStatus.success) {
                    XMDRouter.pushNamedAndRemoveUntil('HomePageRoute');
                  }
                },
                builder: (context, state) {
                  return FilledButton(
                    onPressed: () {
                      AlertUtil.showLoading();
                      context.read<LoginPageCubit>().loginClickedEvent();
                    },
                    child: Text(MultiLanguage.of(context).serverNotFound),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: mSpacing * 2),
                child: const Divider(),
              ),
              //other options
              // IntrinsicHeight(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       //forgot pass button
              //       GestureDetector(
              //           child: Text(R.forgotPassword.translate),
              //           onTap: () =>
              //               NavigationUtil.push(page: ForgotPassPage())),
              //       const VerticalDivider(),
              //       //sign up button
              //       GestureDetector(
              //         child: Text(R.sign_up.translate),
              //         onTap: () => NavigationUtil.push(page: SignupPage()),
              //       ),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
