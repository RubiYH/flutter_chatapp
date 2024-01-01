import 'package:flutter/material.dart';
import 'package:flutter_chatapp/globals.dart';
import 'package:flutter_chatapp/screens/chat_screen.dart';
import 'package:flutter_chatapp/screens/myaccount_detail_screen.dart';
import 'package:ionicons/ionicons.dart';

class ContactListCard extends StatelessWidget {
  final String username;
  final String? avatarURL, nickname, lastChatAt;

  const ContactListCard({
    super.key,
    required this.username,
    this.nickname,
    this.avatarURL,
    this.lastChatAt,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.white60,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyAccountDetailScreen(username: username),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundImage: NetworkImage(globals_default_avatar),
                  radius: 24,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 3,
                        child: Text(
                          username,
                          style: const TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (nickname != null)
                        Flexible(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                "별명: $nickname",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ))
                    ],
                  ),
                ),
                const VerticalDivider(
                  width: 20,
                ),
                InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(username: username),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.messenger_outline_rounded, size: 20),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
