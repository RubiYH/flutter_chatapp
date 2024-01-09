import 'package:flutter/material.dart';
import 'package:flutter_chatapp/components/CommonAppBar.dart';
import 'package:flutter_chatapp/globals.dart';

class SettingsMyAccount extends StatefulWidget {
  const SettingsMyAccount({super.key});

  @override
  State<SettingsMyAccount> createState() => _SettingsMyAccountState();
}

class _SettingsMyAccountState extends State<SettingsMyAccount> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: globals_background_color,
      appBar: CommonAppBar(title: "내 계정"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}
