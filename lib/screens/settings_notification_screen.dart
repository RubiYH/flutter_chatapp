import 'package:flutter/material.dart';
import 'package:flutter_chatapp/components/CommonAppBar.dart';
import 'package:flutter_chatapp/globals.dart';

class SettingsNotification extends StatefulWidget {
  const SettingsNotification({super.key});

  @override
  State<SettingsNotification> createState() => _SettingsNotificationState();
}

class _SettingsNotificationState extends State<SettingsNotification> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: globals_background_color,
      appBar: CommonAppBar(title: "알림 설정"),
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
