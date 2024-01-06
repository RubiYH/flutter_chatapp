import 'package:flutter/material.dart';
import 'package:flutter_chatapp/components/ChatListCard.dart';
import 'package:ionicons/ionicons.dart';

class ChatsList extends StatefulWidget {
  const ChatsList({super.key});

  @override
  State<ChatsList> createState() => _ChatListsState();
}

class _ChatListsState extends State<ChatsList> {
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Ionicons.filter_outline,
                    size: 24,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Ionicons.add_outline,
                    size: 24,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 180,
              height: 40,
              child: TextField(
                focusNode: _focusNode,
                cursorHeight: 20,
                autocorrect: false,
                onTapOutside: (event) => _focusNode.unfocus(),
                decoration: InputDecoration(
                  isDense: true,
                  hintText: "검색",
                  prefixIcon: const Icon(
                    Ionicons.search_outline,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(8),
                  filled: true,
                  fillColor: Colors.black.withOpacity(0.075),
                ),
              ),
            ),
          ],
        ),
        const Column(
          children: [
            SizedBox(
              height: 20,
            ),
            ChatListCard(
              username: "Username",
              sentAt: "1 min ago",
              unread: 1,
            ),
            ChatListCard(
              username: "Usernameweweweweewewewewewe",
              sentAt: "1 min ago",
              message: "dsdsdsdsdsdsdsdsdsdsdsdsddsddsdssdsdsdsdsdsd",
              unread: 1,
            ),
            ChatListCard(
              username: "Username",
              sentAt: "1 min ago",
              unread: 1,
            ),
            ChatListCard(
              username: "Username",
              sentAt: "1 min ago",
              unread: 1,
            ),
            ChatListCard(
              username: "Username",
              sentAt: "1 min ago",
              unread: 1,
            ),
            ChatListCard(
              username: "Username",
              sentAt: "1 min ago",
              unread: 1,
            ),
            ChatListCard(
              username: "Username",
              sentAt: "1 min ago",
              unread: 1,
            ),
            ChatListCard(
              username: "Username",
              sentAt: "1 min ago",
              unread: 1,
            ),
            ChatListCard(
              username: "Username",
              sentAt: "1 min ago",
              unread: 1,
            ),
            ChatListCard(
              username: "Username",
              sentAt: "1 min ago",
              unread: 1,
            ),
          ],
        )
      ],
    );
  }
}
