import 'package:flutter/material.dart';
import 'package:flutter_chatapp/globals.dart';
import 'package:flutter_chatapp/screens/chat_screen.dart';

class ChatListCard extends StatelessWidget {
  final String username, message, sentAt, avatarURL;
  final int unread;

  const ChatListCard(
      {super.key,
      required this.username,
      this.message = "메시지가 없습니다.",
      required this.sentAt,
      this.unread = 0,
      this.avatarURL = globals_default_avatar});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(username: username),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(avatarURL),
                            radius: 16,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              username,
                              style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 28,
                      height: 28,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            unread.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    message,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    sentAt,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
