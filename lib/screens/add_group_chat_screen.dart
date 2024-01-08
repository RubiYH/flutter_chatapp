import 'package:flutter/material.dart';
import 'package:flutter_chatapp/components/CommonAppBar.dart';
import 'package:flutter_chatapp/globals.dart';
import 'package:flutter_chatapp/screens/chat_screen.dart';
import 'package:flutter_chatapp/screens/contactsList_screen.dart';
import 'package:ionicons/ionicons.dart';

class AddGroupChat extends StatefulWidget {
  const AddGroupChat({
    super.key,
  });

  @override
  State<AddGroupChat> createState() => _AddGroupChatState();
}

class _AddGroupChatState extends State<AddGroupChat> {
  Map selectedUsersMap = {};
  List selectedUsers = [];
  String? groupChatName;

  void afterSelected() {
    groupChatName = null;
    _textController.text = "";
    setState(() {});
  }

  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _textController.addListener(() {
      var text = _textController.text.trim();
      if (text.isNotEmpty) groupChatName = text;
    });
  }

  void createGroupChat(BuildContext ctx, String listAllUsers) async {
    if (groupChatName == null || groupChatName!.isEmpty) {
      if (listAllUsers.length > 20) {
        groupChatName = "새 그룹 채팅 (${selectedUsers.length})";
      } else {
        groupChatName = "$listAllUsers (${selectedUsers.length})";
      }
    }

    await Navigator.of(ctx).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          isGroup: true,
          groupTitle: groupChatName,
        ),
      ),
      ModalRoute.withName(
        Navigator.defaultRouteName,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: "새 그룹 채팅",
        actions: [
          if (selectedUsersMap.length > 1)
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (ctx) {
                      selectedUsers = [];
                      selectedUsersMap
                          .forEach((key, value) => selectedUsers.add(value));

                      var listAllUsers = selectedUsers.join(", ");
                      var hintText = listAllUsers.length > 20
                          ? "새 그룹 채팅 (${selectedUsers.length})"
                          : "$listAllUsers (${selectedUsers.length})";

                      return AlertDialog(
                        actionsAlignment: MainAxisAlignment.end,
                        contentPadding: const EdgeInsets.all(16),
                        backgroundColor: Colors.white,
                        surfaceTintColor: Colors.white,
                        scrollable: true,
                        content: Column(
                          children: [
                            const Text(
                              "새 그룹 채팅 이름",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextField(
                              controller: _textController,
                              autocorrect: false,
                              decoration: InputDecoration(hintText: hintText),
                              keyboardType: TextInputType.text,
                              maxLength: 20,
                            ),
                          ],
                        ),
                        actionsPadding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(ctx);
                                  },
                                  child: const Text(
                                    "취소",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextButton(
                                  onPressed: () =>
                                      createGroupChat(ctx, listAllUsers),
                                  child: const Text(
                                    "확인",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      );
                    });
              },
              icon: const Icon(Ionicons.arrow_forward_outline),
            ),
        ],
      ),
      backgroundColor: globals_background_color,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ContactsList(
          showActions: false,
          showAddButton: false,
          groupChat: true,
          selectedUsersMap: selectedUsersMap,
          afterSelected: afterSelected,
        ),
      ),
    );
  }
}
