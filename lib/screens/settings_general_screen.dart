import 'package:flutter/material.dart';
import 'package:flutter_chatapp/components/CommonAppBar.dart';
import 'package:flutter_chatapp/globals.dart';

class SettingsGeneral extends StatefulWidget {
  const SettingsGeneral({super.key});

  @override
  State<SettingsGeneral> createState() => _SettingsGeneralState();
}

class _SettingsGeneralState extends State<SettingsGeneral> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: globals_background_color,
      appBar: CommonAppBar(title: "환경 설정"),
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
