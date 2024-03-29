import 'dart:async';
import 'package:configuration/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:configuration/style/style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmteam/presentation/welcome/cubit/welcome_cubit.dart';
import 'package:wmteam/utils/alert_util.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  double opacityLevel = 0.0;
  Timer? _timer;

  void _changeOpacity() {
    setState(() => opacityLevel = opacityLevel == 0 ? 1.0 : 0.0);
  }

  @override
  void initState() {
    super.initState();
    _timer =
        Timer.periodic(const Duration(seconds: 2), (timer) => _changeOpacity());
    context.read<WelcomeCubit>().init();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WelcomeCubit, WelcomeState>(
      listener: (context, state) {
        switch (state.status) {
          ///Has execute in event change auth
          // case WelcomeStatus.newUser:
          //   XMDRouter.pushNamedAndRemoveUntil(routerIds[IntroductionRoute]!);
          //   break;
          // case WelcomeStatus.login:
          //   XMDRouter.pushNamedAndRemoveUntil(routerIds[HomeRoute]!);
          //   break;
          case WelcomeStatus.error:
            AlertUtil.showToast(MultiLanguage.of(context).systemError);
            break;
          default:
            break;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: null,
          body: Container(
            decoration: BoxDecoration(color: mCLightBackground),
            child: AnimatedOpacity(
                duration: const Duration(seconds: 2),
                opacity: opacityLevel,
                child: Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Image(
                          image: AssetImage("assets/img/logo.png"),
                          width: 75,
                        ),
                        SizedBox(width: mSpacing),
                        const Text(
                          "WMTeam",
                          style: mST32M,
                        )
                      ]),
                )),
          ),
        );
      },
    );
  }
}
