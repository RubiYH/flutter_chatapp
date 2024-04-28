import 'package:flutter/material.dart';
import 'package:flutter_chatapp/screens/settings_chat_screen.dart';
import 'package:flutter_chatapp/screens/settings_general_screen.dart';
import 'package:flutter_chatapp/screens/settings_myaccount_screen.dart';
import 'package:flutter_chatapp/screens/settings_notification_screen.dart';
import 'package:ionicons/ionicons.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final List<Map<String, dynamic>> menuData = [
    {
      "name": "내 계정",
      "icon": const Icon(Ionicons.person_circle_outline),
      "route": const SettingsMyAccount(),
    },
    {
      "name": "채팅 설정",
      "icon": const Icon(Ionicons.chatbubble_ellipses_outline),
      "route": const SettingsChat()
    },
    {
      "name": "알림 설정",
      "icon": const Icon(Ionicons.notifications_outline),
      "route": const SettingsNotification()
    },
    {
      "name": "환경 설정",
      "icon": const Icon(Ionicons.cog_outline),
      "route": const SettingsGeneral()
    }
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: menuData.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => menuData[index]["route"],
                ),
              );
            },
            child: ListTile(
              title: Text(
                menuData[index]["name"],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              leading: menuData[index]["icon"],
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            indent: 10,
            endIndent: 10,
            color: Colors.grey.shade300,
            thickness: 0.5,
          );
        },
      ),
    );
  }
}
