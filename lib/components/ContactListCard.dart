import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatapp/components/SwipeUpPageRouteBuilder.dart';
import 'package:flutter_chatapp/globals.dart';
import 'package:flutter_chatapp/screens/chat_screen.dart';
import 'package:flutter_chatapp/screens/contact_detail_screen.dart';
import 'package:ionicons/ionicons.dart';

class ContactListCard extends StatefulWidget {
  final String username, id;
  final String? avatarURL, nickname, lastChatAt;
  final bool showActions, newChat, groupChat;
  final Map selectedUsersMap;
  final Function? onSelected;

  const ContactListCard({
    super.key,
    required this.id,
    required this.username,
    this.nickname,
    this.avatarURL,
    this.lastChatAt,
    this.showActions = true,
    this.newChat = false,
    this.groupChat = false,
    this.selectedUsersMap = const {},
    this.onSelected,
  });

  @override
  State<ContactListCard> createState() => _ContactListCardState();
}

class _ContactListCardState extends State<ContactListCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.groupChat ? 90 : 110,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: widget.newChat
              ? () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ChatScreen(username: widget.username),
                    ),
                    ModalRoute.withName(
                      Navigator.defaultRouteName,
                    ),
                  )
              : widget.groupChat
                  ? () {
                      widget.onSelected!(
                        widget.id,
                        widget.username,
                        widget.selectedUsersMap[widget.id] == null
                            ? true
                            : false,
                      );
                    }
                  : () {
                      Navigator.push(
                        context,
                        SwipeUpPageRouteBuilder(
                          ContactDetailScreen(
                            username: widget.username,
                            id: widget.id,
                          ),
                        ),
                      );
                    },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    widget.avatarURL ?? globals_default_avatar,
                  ),
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
                          widget.username,
                          style: const TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (widget.nickname != null || widget.lastChatAt != null)
                        Flexible(
                          flex: 1,
                          child: Row(
                            children: [
                              if (widget.nickname != null)
                                Flexible(
                                  child: Text(
                                    "별명: ${widget.nickname}",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              const SizedBox(
                                width: 10,
                              ),
                              if (widget.lastChatAt != null)
                                Flexible(
                                  child: FittedBox(
                                    child: Text(
                                      "마지막 채팅: ${widget.lastChatAt}",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        )
                    ],
                  ),
                ),
                if (widget.showActions)
                  Row(
                    children: [
                      const VerticalDivider(
                        width: 20,
                        indent: 10,
                        endIndent: 10,
                      ),
                      InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ChatScreen(username: widget.username),
                            ),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child:
                              Icon(Icons.messenger_outline_rounded, size: 20),
                        ),
                      ),
                    ],
                  ),
                if (widget.groupChat)
                  Checkbox(
                    value: (widget.selectedUsersMap[widget.id] == null)
                        ? false
                        : true,
                    onChanged: widget.onSelected != null
                        ? (bool? checked) {
                            widget.onSelected!(
                                widget.id, widget.username, checked);
                          }
                        : null,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
