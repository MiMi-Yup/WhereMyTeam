import 'package:configuration/l10n/l10n.dart';
import 'package:flutter/material.dart';

class AccountSetupScreen extends StatefulWidget {
  const AccountSetupScreen({super.key});

  @override
  State<AccountSetupScreen> createState() => _AccountSetupScreenState();
}

class _AccountSetupScreenState extends State<AccountSetupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(MultiLanguage.of(context).connectTimeout),
        ),
        body: Center());
  }
}
