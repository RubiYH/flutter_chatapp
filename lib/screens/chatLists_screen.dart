import 'package:flutter/material.dart';
import 'package:flutter_chatapp/components/ChatListCard.dart';
import 'package:ionicons/ionicons.dart';

class ChatLists extends StatefulWidget {
  const ChatLists({super.key});

  @override
  State<ChatLists> createState() => _ChatListsState();
}

class _ChatListsState extends State<ChatLists> {
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 200,
              child: TextField(
                focusNode: _focusNode,
                onTapOutside: (event) => _focusNode.unfocus(),
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: const Icon(Ionicons.search_outline),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24.0),
                      borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.all(8),
                  filled: true,
                  fillColor: Colors.black.withOpacity(0.1),
                ),
              ),
            ),
          ],
        ),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 20,
            ),
            ChatListCard(),
            ChatListCard(),
            ChatListCard(),
            ChatListCard(),
            ChatListCard(),
            ChatListCard(),
            ChatListCard(),
            ChatListCard(),
            ChatListCard(),
            ChatListCard(),
            ChatListCard(),
          ],
        )
      ],
    );
  }
}
