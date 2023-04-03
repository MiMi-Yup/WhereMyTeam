import 'package:configuration/l10n/l10n.dart';
import 'package:configuration/route/xmd_router.dart';
import 'package:flutter/material.dart';
import 'package:where_my_team/utils/extensions/context_extension.dart';
import 'package:configuration/style/style.dart';

class StartPageScreen extends StatelessWidget {
  const StartPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Image.asset("assets/img/boarding.jpg"),
        bottomSheet: SizedBox(
            height: context.screenSize.height / 3,
            width: double.maxFinite,
            child: Padding(
              padding: EdgeInsets.all(mPaddingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    MultiLanguage.of(context).connectTimeout,
                    textAlign: TextAlign.start,
                    style: textStylePrimary,
                  ),
                  SizedBox(height: mSpacing * 3),
                  Text(
                    MultiLanguage.of(context).connectTimeout,
                    textAlign: TextAlign.start,
                  ),
                  const Spacer(),
                  FilledButton(
                    onPressed: () => {XMDRouter.pushNamed('LoginPageRoute')},
                    child: Text(
                      MultiLanguage.of(context).connectTimeout,
                    ),
                  ),
                ],
              ),
            )));
  }
}
