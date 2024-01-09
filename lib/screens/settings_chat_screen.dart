import 'package:flutter/material.dart';
import 'package:flutter_chatapp/components/CommonAppBar.dart';
import 'package:flutter_chatapp/globals.dart';

class SettingsChat extends StatefulWidget {
  const SettingsChat({super.key});

  @override
  State<SettingsChat> createState() => _SettingsChatState();
}

class _SettingsChatState extends State<SettingsChat> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: globals_background_color,
      appBar: CommonAppBar(title: "채팅 설정"),
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
