import 'package:flutter/material.dart';
import 'package:flutter_chatapp/components/ChatListCard.dart';
import 'package:flutter_chatapp/components/FilterPopUpMenu.dart';
import 'package:flutter_chatapp/components/SwipeUpPageRouteBuilder.dart';
import 'package:flutter_chatapp/models/user_chatListCard_model.dart';
import 'package:flutter_chatapp/modules/getListFromPrefs_module.dart';
import 'package:flutter_chatapp/modules/updateListToPrefs_module.dart';
import 'package:flutter_chatapp/screens/add_group_chat_screen.dart';
import 'package:flutter_chatapp/screens/add_single_chat_screen.dart';
import 'package:ionicons/ionicons.dart';

class ChatsList extends StatefulWidget {
  const ChatsList({super.key});

  @override
  State<ChatsList> createState() => _ChatListsState();
}

class _ChatListsState extends State<ChatsList> {
  final _focusNode = FocusNode();
  final TextEditingController _textController = TextEditingController();

  late List<UserChatListCardModel> UpdatedList = [];
  late List<UserChatListCardModel> ChatsList = [];
  late List<UserChatListCardModel> SearchList = [];

  @override
  void initState() {
    super.initState();

    _textController.addListener(() {
      var searchValue = _textController.text.trim();

      if (searchValue.isEmpty) {
        UpdatedList = ChatsList;
        return;
      }

      SearchList = ChatsList.where((u) =>
              u.username.toLowerCase().contains(searchValue.toLowerCase()))
          .toList();
      UpdatedList = SearchList;

      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  getData() async {
    if (ChatsList.isEmpty) {
      await getListFromPrefs("Chats", (item) {
        ChatsList.add(UserChatListCardModel.fromJson(item));
      });
      UpdatedList = ChatsList;
    }

    return ChatsList;
  }

  void onFilterChange(item) {
    switch (item) {
      case filterChatMenu.latest:
        UpdatedList.sort((a, b) {
          if (a.rawlastChatAt == null && b.rawlastChatAt == null) {
            return 0;
          } else if (b.rawlastChatAt == null) {
            return -1;
          } else if (a.rawlastChatAt == null) {
            return 1;
          } else {
            return DateTime.parse(b.rawlastChatAt!)
                .compareTo(DateTime.parse(a.rawlastChatAt!));
          }
        });
        break;

      case filterChatMenu.unread:
        UpdatedList.sort((a, b) {
          if (a.unreads == null && b.unreads == null) {
            return 0;
          } else {
            return b.unreads.compareTo(a.unreads);
          }
        });
        break;

      case filterChatMenu.alphabetic:
      default:
        UpdatedList.sort(
          (a, b) => a.username.compareTo(b.username),
        );
        break;
    }

    updateListToPrefs("Chats", ChatsList);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                FilterPopupMenu(onChange: onFilterChange, type: "ChatsList"),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (ctx) {
                        return AlertDialog(
                          contentPadding: EdgeInsets.zero,
                          backgroundColor: Colors.white,
                          surfaceTintColor: Colors.white,
                          scrollable: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          content: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(24),
                                    bottomLeft: Radius.circular(24),
                                  ),
                                  onTap: () {
                                    Navigator.pop(ctx);
                                    Navigator.push(
                                      ctx,
                                      SwipeUpPageRouteBuilder(
                                        const AddSingleChat(),
                                      ),
                                    );
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 28,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          "1:1 채팅",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Icon(
                                          Ionicons.chatbubble_outline,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(24),
                                    bottomRight: Radius.circular(24),
                                  ),
                                  onTap: () {
                                    Navigator.pop(ctx);
                                    Navigator.push(
                                      ctx,
                                      SwipeUpPageRouteBuilder(
                                        const AddGroupChat(),
                                      ),
                                    );
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 28,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          "그룹 채팅",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Icon(
                                          Ionicons.chatbubbles_outline,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
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
                controller: _textController,
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
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      if (UpdatedList.isNotEmpty)
                        for (var data in UpdatedList)
                          ChatListCard(
                            username: data.username,
                            id: data.id,
                            avatarURL: data.avatarURL,
                            lastMessage: data.lastMessage,
                            lastChatAt: data.lastChatAt,
                            unreads: data.unreads,
                          )
                      else
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Column(
                            children: [
                              const Text(
                                "메시지가 없습니다.",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              if (ChatsList.isEmpty)
                                const Text(
                                  "+ 아이콘을 눌러 채팅을 시작하세요.",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                            ],
                          ),
                        )
                    ],
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      "오류가 발생하였습니다.",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        )
      ],
    );
  }
}
